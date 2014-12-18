module V1
  class Api::V1::DealsController < Api::V1::BaseApiController
    before_action :set_deal, only: [:show, :edit, :update, :destroy]

    before_filter do
      if current_business != nil
        puts "business"
        :authenticate_business!        
      else
        puts "user"
        :authenticate_user!
      end
    end

    def index
      @deals = Deal.all
      render json: @deals.to_json
    end

    def show
      respond_with(@deal)
    end

    def new
      @deal = Deal.new
      render json: @deal.to_json 
    end

    def edit
    end

    def create
      @deal = Deal.new(deal_params)
      @deal.save
      respond_with(@deal)
    end

    def update
      @deal.update(deal_params)
      respond_with(@deal)
    end

    def destroy
      @deal.destroy
      respond_with(@deal)
    end

    private
      def set_deal
        @deal = Deal.find(params[:id])
      end

      def deal_params
        params.require(:deal).permit(:name, :price, :expires_at, :description)
      end
  end
end