class ResumeDocumentsController < ApplicationController
  before_action :set_resume, only: [:edit, :update, :destroy]
  load "#{Rails.root}/lib/text_analyze.rb"
  load "#{Rails.root}/lib/experience_calculation.rb"

  def show
    if employer_signed_in?
      redirect_to employer_show_view_resume_documents_path(:id=>params[:id], :job_id=>params[:job_id])
    end
    @user=User.find(params[:id])
     if (File.file?("#{Rails.root}/#{@user.resume_document.datafile}")) 
       @resume_hash=JSON.parse(IO.read("#{Rails.root}/#{@user.resume_document.datafile}"))
     else
       redirect_to root_path
     end
  end
  
  def employer_show_view
    @user=User.find(params[:id])
    @resume_data=JSON.parse(IO.read("#{Rails.root}/#{@user.resume_document.datafile}"))
    @job=Job.find(params[:job_id])
    @job_data=JSON.parse(IO.read("#{Rails.root}/#{@job.datafile}"))
    @matching_data=matching(@job_data, @resume_data)
    @result_hash=compare(@matching_data)
  end

  def new
    @resume=ResumeDocument.new
  end

  def create
      @resume=ResumeDocument.new(resume_params)
      @resume.filename=File.basename(@resume.attachment_url)
      @resume.user=current_user
      if @resume.save
        LongCalculationJob.perform_later(@resume.user.id)
        redirect_to root_path, notice: 'Resume was successfully uploaded.'
      else
        render :new
      end
  end

  def destroy
    @resume=ResumeDocument.find(params[:id])
    File.delete("#{Rails.root}/public/#{@resume.attachment_url}")
    File.delete("#{Rails.root}/#{@resume.datafile}")
    @resume.destroy
    redirect_to root_path, notice: 'The resume has been deleted.'
  end
  private
    def set_resume
      @resume=ResumeDocument.find(params[:id])
    end

    def resume_params
      params.require(:resume_document).permit(:filename, :attachment)
    end
end
