class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  acts_as_token_authentication_handler_for Business, fallback_to_devise: false
  respond_to :json

  def angular
    render 'layouts/application'
  end

  protected

  def after_sign_in_path_for(resource)
    feed_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :category, :password, :remember_me, :about, :phone_number, :name, full_address: [:street, :city, :state], avatar_attributes: [:direct_upload_url]) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :category, :password, :remember_me, avatar_attributes: [:direct_upload_url]) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :category, :password, :current_password, avatar_attributes: [:direct_upload_url]) }
  end
end
