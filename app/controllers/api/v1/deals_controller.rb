class Api::V1::DealsController < Api::V1::BaseController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  #before_filter :authenticate_business!, except: [:index, :show]

  private

    def set_deal
      @deal = Deal.find(params[:id])
    end

    def deal_params
      params.require(:deal).permit(:name, :price, :expires_at, :description, :business_id)
    end

    def query_params
      params.permit(:name, :price, :expires_at, :description, :business_id)
    end
end
