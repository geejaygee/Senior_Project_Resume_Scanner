class LongCalculationJob < ActiveJob::Base
  queue_as :default
  load "#{Rails.root}/lib/text_analyze.rb"
  load "#{Rails.root}/lib/experience_calculation.rb"
  def perform(user_id)
    @user=User.find(user_id)
    if @user
      resume_file=@user.resume_document.attachment_url
      goodstuff=$client.post('extracttext', {:mode=>'document', :file=>open('public' + resume_file,'r')})
    yourjson=goodstuff.json()
    sometext=yourjson["document"][0]["content"]
    experience=Array.new
    experience=experience_calc(sometext)
    skills=Array.new
    skills=analyze(sometext)
    certification=Array.new
    certification=find_certification(sometext)
    education=Array.new
    education=education(sometext)
    skill_group=Array.new
    skill_group=flag_set(skills)
    myhash={"education"=>education, "experience"=>experience, "certification"=>certification, "skills"=>skills, "skill group"=>skill_group}
      File.open('public'+File.dirname(resume_file)+'/data'+@user.id.to_s+'.json', "w+") do |f|
        f.write(JSON.generate(myhash))
      end
    end
    @user.resume_document.update_attribute(:datafile, 'public'+File.dirname(resume_file)+'/data'+@user.id.to_s+'.json')
  end
end
