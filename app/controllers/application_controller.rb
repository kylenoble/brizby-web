class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  acts_as_token_authentication_handler_for Business, fallback_to_devise: false

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :remember_me, :profile_pic, profile_pic_attributes: [:image]) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me, profile_pic_attributes: [:image]) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password, profile_pic_attributes: [:image]) }
  end
end
