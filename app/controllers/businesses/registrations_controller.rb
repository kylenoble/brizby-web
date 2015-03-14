class Businesses::RegistrationsController < Devise::RegistrationsController

  def create
    merge_address
    @business = Business.create(business_params) { |q| q.full_address = @business_address }
    if @business.save
      sign_in(@business)
      respond_with(@business)
    else
      respond_with(@business.errors.full_messages)
    end
  end
  
  private

  def business_params
    params.require(:business).permit(:email, :password, :name, :about, :category, :phone_number, full_address: [:street, :city, :state], avatar_attributes: [:direct_upload_url])
  end

  def merge_address
    @business_address = ""
    business_params[:full_address].each do |key, val| 
      if key == "state"
        val = val + " "
      else
        val = val + ", "
      end
      @business_address += val
    end
  end
end
