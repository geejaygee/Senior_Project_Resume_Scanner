class ResumeDocumentsController < ApplicationController
  load "#{Rails.root}/lib/filename_generator.rb"
  before_action :set_resume, only: [ :show, :edit, :update, :destroy]

  def show
    @user=User.find(@resume.user_id)
  end

  def new
    @resume=ResumeDocument.new
  end

  def create
    @resume=ResumeDocument.new(resume_params)
    @resume.user=current_user
    if @resume.save
      redirect_to root_path, notice: 'Resume was successfully uploaded.'
    else
      render :new
    end
  end

  def destroy
    @resume=ResumeDocument.find(params[:id])
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
