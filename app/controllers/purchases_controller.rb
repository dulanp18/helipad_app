class PurchasesController < ApplicationController

  def index
    @user = current_user
    @purchases = Purchase.where(user_id: @user.id)
  end

  def show
    @purchase = Purchase.find(params[:listing_id])
  end

  def new
    @listing = Listing.find(params[:listing_id])
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.user = current_user
    if @purchase.save
      redirect_to purchase_path
    else
      render :new
    end
  end

  def edit
    @purchase = Purchase.find(params[:id])
  end

  def update
    @purchase = Purchase.find(params[:id])
    @purchase = Purchase.update(purchase_params)
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy
    redirect_to purchase_path
  end

  private

  def find_listing
    params.id
  end

  def purchase_params
    params.require(:purchase).permit(:start_time, :finish_time, :total_cost)
  end
end
