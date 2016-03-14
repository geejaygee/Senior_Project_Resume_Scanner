class JobsController < ApplicationController
  before_action :set_job, only: [ :show, :edit, :update, :destroy, :applicants]

  def all_index
    @employers = Employer.all
    @jobs = Job.all
  end

  def show
    @employer=Employer.find(@job.employer_id)
    @applied=false
    if user_signed_in?
      @user=current_user
      @applications=current_user.job_applications.map{|job_application| job_application.job} 
      @applications.each do |app|
        if app.id==@job.id
          @applied=true
        end
      end
      @job_application=@user.job_applications.new
      @matching_words=Array.new
      goodstuff=$client.post('extracttext', {:mode=>'document', :file=>open('public' + current_user.resume_document.attachment_url,'r')})
      yourjson=goodstuff.json()
      resume_text=yourjson["document"][0]["content"]
      goodstuff=$client.post('extracttext', {:mode=>'document', :file=>open('public' + @job.attachment_url,'r')})
      yourjson=goodstuff.json()
      job_text=yourjson["document"][0]["content"]
      @resume_words=analyze(resume_text)
      @job_words=analyze(job_text)
      @result=compare(@resume_words, @job_words)
    end
  end

  def top_job
      @tophash=Hash.new()
      goodstuff=$client.post('extracttext', {:mode=>'document', :file=>open('public' + current_user.resume_document.attachment_url,'r')})
      yourjson=goodstuff.json()
      resume_text=yourjson["document"][0]["content"]
      @resume_words=analyze(resume_text)
      @jobs=Job.all
      @jobs.each do |job|
        @matching_words=Array.new()
        goodstuff=$client.post('extracttext', {:mode=>'document', :file=>open('public' + job.attachment_url,'r')})
        yourjson=goodstuff.json()
        job_text=yourjson["document"][0]["content"]
        @job_words=analyze(job_text)
        @result=compare(@resume_words, @job_words)
        @tophash[@jobs.index(job)]=[@result, job]
      end
      @tophash=@tophash.sort_by {|key, value| value[0]}.reverse
      @tophash=@tophash[0,5]

  end

  def my_index
    if employer_signed_in?
      @jobs=Job.joins(:employer).where(:employer_id => params[:id])
    else
      @applications=current_user.job_applications.map{|job_app| job_app.job}
      @jobs=Job.all
    end
  end

  def applicants
 
  end

  def new
    @job=Job.new
    @job.job_applications.new
  end

  def create
    if params[:job][:attachment].blank?
      redirect_to new_job_path, notice: 'Job listing file cannot be blank.'
    else
      @job=Job.new(job_params)
      @job.filename=File.basename(@job.attachment_url)
      @job.employer=current_employer
      if @job.save
        redirect_to root_path, notice: 'Job was successfully uploaded.'
      else
        render :new
      end
    end
  end

  def destroy
    @job=Job.find(params[:id])
    @job.destroy
    redirect_to root_path, notice: 'The job has been deleted.'
  end
  private
    def set_job
      @job=Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:position, :filename, :attachment)
    end
end
