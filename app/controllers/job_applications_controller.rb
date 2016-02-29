class JobApplicationsController < ApplicationController

  def new
    @job = Job.find params[:job_id]
    @job_application = @job.job_applications.new
   end

   def create
     @job = Job.find(params[:job_id])
     @job_application = @job.job_applications.new(job_application_params)
     if @job_application.save
       redirect_to job_url(@job), notice: 'You have successfully applied.'
     else
       redirect_to job_url(@job), notice: 'Couldnt apply, try again.'
     end
   end

  private
  
  def set_job_application
    @job_application=JobApplication.find(params[:id])
  end

  def job_application_params
    params.require(:job_application).permit(:user_id, :job_id)
  end
end
