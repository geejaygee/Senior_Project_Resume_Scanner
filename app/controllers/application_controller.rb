class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
#  def devise_parameter_sanitizer
 #   if resource_class == Employer
 #     Employer::ParameterSanitizer.new(Employer, :employer, params)
 #   else
  #    super
 #   end
#  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)<<:name
    devise_parameter_sanitizer.for(:account_update)<<:name
  end
  private
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
