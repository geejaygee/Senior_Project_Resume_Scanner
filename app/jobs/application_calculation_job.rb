class ApplicationCalculationJob < ActiveJob::Base
  queue_as :default

  def perform(job_id)
    @job=Job.find(job_id)
    job_file=@job.attachment_url
    goodstuff=$client.post('extracttext', {:mode=>'document', :file=>open('public' + @job.attachment_url,'r')})
    yourjson=goodstuff.json()
    job_text=yourjson["document"][0]["content"]
    industry=job_industry(@job.position, job_text)
    job_experience=Hash.new
    job_education=Hash.new
    job_skills=Array.new
    job_experience=experience_calc_job(job_text)
    job_education=education_req(job_text, @job.position)
    job_skills=analyze(job_text)
    myhash={"education"=>job_education, "experience"=>job_experience, "skills"=>job_skills}
      File.open('public'+File.dirname(job_file)+'/data'+@job.id.to_s+'.json', "w+") do |f|
        f.write(JSON.generate(myhash))
      end
    @job.update_attribute(:datafile, 'public'+File.dirname(job_file)+'/data'+@job.id.to_s+'.json')
  end
end
