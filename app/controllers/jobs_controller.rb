class JobsController < ApplicationController
  load "#{Rails.root}/lib/filename_generator.rb"
  before_action :set_job, only: [ :show, :edit, :update, :destroy]

  def index
    @employers = Employer.all
    @jobs = Job.all
  end
  def show
    @employer=Employer.find(@job.employer_id)
  end

  def new
    @job=Job.new
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
