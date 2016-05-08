class JobsController < ApplicationController
  before_action :set_job, only: [ :show, :user_show_view, :edit, :update, :destroy, :applicants]

  def all_index
    @employers = Employer.all
    @jobs = Job.all
  end

  def show
    if user_signed_in?
      redirect_to user_show_view_jobs_path(:id=>@job.id)
    end
    @employer=Employer.find(@job.employer_id)
    @job_data=JSON.parse(IO.read("#{Rails.root}/#{@job.datafile}"))
  end
  
  def user_show_view
    @employer=Employer.find(@job.employer_id)
    @applied=false
    @job_data=JSON.parse(IO.read("#{Rails.root}/#{@job.datafile}"))
    @user=User.find(current_user)
    @apple=false
    if @user.resume_document.filename
      @applications=@user.job_applications.map{|job_application| job_application.job}
      @applications.each do |app|
        if app.id==@job.id
          @applied=true
        end
      end
      @job_application=@user.job_applications.new
      @apple=true
      @resume_data=JSON.parse(IO.read("#{Rails.root}/#{@user.resume_document.datafile}"))
      @matching_data=matching(@job_data, @resume_data)
      @result_hash=compare(@matching_data)
    end
  end

  def top_job
      @tophash=Hash.new()
      @industry_hash=Hash.new()
      @user=User.find(current_user)
      @resume_data=JSON.parse(IO.read("#{Rails.root}/#{@user.resume_document.datafile}"))
      @jobs=Job.all
      @jobs.each do |job|
        if @job_data=JSON.parse(IO.read("#{Rails.root}/#{job.datafile}"))
          @matching_data=matching(@job_data, @resume_data)
          @result_hash=compare(@matching_data)
          if @industry_hash[@job_data["industry"]]          
            @industry_hash[@job_data["industry"]]=((@industry_hash[@job_data["industry"]]+ @result_hash["total"])/2)
          else
            @industry_hash[@job_data["industry"]]=@result_hash["total"]
          end
          @tophash[@jobs.index(job)]=[@result_hash["total"], job]
        end
      end
      @tophash=@tophash.sort_by {|key, value| value[0]}.reverse
      @tophash=@tophash[0,5]
      @industry_hash=@industry_hash.sort_by{|key, value| value}.reverse
      @industry_hash=@industry_hash[0,5]
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
      @job.hyperlink.lstrip!
      if (!@job.hyperlink.empty?)&&(!(@job.hyperlink=~/http:\/\/.*|https:\/\/.*/))
        @job.hyperlink="http://"+@job.hyperlink
      end
      if @job.save
        ApplicationCalculationJob.perform_later(@job.id)
        redirect_to root_path, notice: 'Job was successfully uploaded.'
      else
        render :new
      end
    end
  end

  def destroy
    @job=Job.find(params[:id])
    File.delete("#{Rails.root}/public/#{@job.attachment}")
    File.delete("#{Rails.root}/#{@job.datafile}")
    @job.destroy
    redirect_to root_path, notice: 'The job has been deleted.'
  end
  private
    def set_job
      @job=Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:position, :filename, :attachment, :description, :hyperlink, :job_type)
    end
end
