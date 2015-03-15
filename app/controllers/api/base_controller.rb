class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  respond_to :json
  skip_before_filter :verify_authenticity_token
end