class ResumeDocumentsController < ApplicationController
  before_action :set_resume, only: [ :edit, :update, :destroy]
  load "#{Rails.root}/lib/text_analyze.rb"
  def show
    @user=User.find(params[:id])
    goodstuff=$client.post('extracttext', {:mode=>'document', :file=>open('public' + @user.resume_document.attachment_url,'r')})
    yourjson=goodstuff.json()
    @sometext=yourjson["document"][0]["content"] 
    @match=Array.new
    @matching=Array.new
    @matching=analyze(@sometext)        
  end

  def new
    @resume=ResumeDocument.new
  end

  def create
    if (params[:resume_document][:attachment]).blank?
      redirect_to new_resume_document_path, notice: 'Resume cannot be blank.'
    else
    @resume=ResumeDocument.new(resume_params)
    @resume.filename=File.basename(@resume.attachment_url)
    @resume.user=current_user
    if @resume.save
      redirect_to root_path, notice: 'Resume was successfully uploaded.'
    else
      render :new
    end
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
