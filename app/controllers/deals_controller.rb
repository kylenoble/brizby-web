class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_business!, except: [:index, :show]

  respond_to :html

  def index
    @deals = Deal.all
    respond_with(@deals)
  end

  def show
    respond_with(@deal)
  end

  def new
    @deal = Deal.new
    respond_with(@deal)
  end

  def edit
  end

  def create
    @deal = Deal.new(deal_params)
    @business = current_business
    @deal.business_id = @business.id

    if @deal.save
      @deal.create_activity :create, owner: @business
    end
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
      params.require(:deal).permit(:name, :price, :expires_at, :description, :business_id)
    end
end