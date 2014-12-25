class Businesses::RegistrationsController < Devise::RegistrationsController
  def create
    @business = Business.create(business_params)
    if @business.save
      render :json => {:state => {:code => 0}, :data => @business }
    else
      render :json => {:state => {:code => 1, :messages => @business.errors.full_messages} }
    end
  end
  
  private

  def business_params
    params.require(:api_v1_business).permit(:email, :password, profile_pic_attributes: [:image])
  end
end