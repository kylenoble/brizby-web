class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  respond_to :json
  skip_before_filter :verify_authenticity_token, if: :json_request?

  @test = "test"

  private

  def json_request?
    request.format.json?
  end
end