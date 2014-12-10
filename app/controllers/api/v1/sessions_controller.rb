module V1
  class Api::V1::SessionsController < Devise::SessionsController
    protect_from_forgery :except => [:create, :destroy]
    def create
     self.resource = warden.authenticate!(auth_options)
     sign_in(resource_name, resource)
   
     current_api_v1_user.update authentication_token: nil
   
     render :json => {
       :user => current_api_v1_user,
       :status => :ok,
       :authentication_token => current_api_v1_user.authentication_token
     }
    end

    # DELETE /resource/sign_out
    def destroy
      if current_api_v1_user
        current_api_v1_user.update authentication_token: nil
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        render :json => {}.to_json, :status => :ok
      else
        render :json => {}.to_json, :status => :unprocessable_entity
      end
    end
  end
end