class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	include Pundit
  helper_method :super_admin

  protected

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def super_admin
    if user_signed_in? && current_user.super_user == true && current_user.email == "jmgrant702@gmail.com"
      current_user
    else
      nil
    end
  end
end
