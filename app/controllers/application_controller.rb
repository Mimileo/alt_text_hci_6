class ApplicationController < ActionController::Base
  require 'pagy'
  require 'action_text'

	before_action :configure_permitted_parameters, if: :devise_controller?
	include Pundit
  include Pagy::Backend

  helper_method :super_admin
  helper_method :referee
  helper_method :contributor


  protected

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def super_admin
    if user_signed_in? && current_user.super_user == true && (current_user.email == "kate@seven.army" || current_user.email == "mleon11@ucsc.edu" || current_user.email == "justin@accr.biz")
      current_user
    else
      nil
    end
  end

  def referee
    if user_signed_in? && current_user.referee == true
      current_user
    else
      nil
    end
  end

  def contributor
    if user_signed_in? && current_user.contributor == true
      current_user
    else
      nil
    end
  end
end
