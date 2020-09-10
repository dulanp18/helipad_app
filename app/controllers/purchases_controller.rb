class PurchasesController < ApplicationController

  def index
    @user = current_user
    @purchases = Purchase.where(user_id: @user.id)
  end

  def show
    @listing = Listing.fing(params[:listing_id])
    @purchase = Purchase.find(params[:id])
  end

  def new
    @listing = Listing.find(params[:listing_id])
    @purchase = Purchase.new
    @purchase.listing = @listing
    @purchase.user = current_user
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @purchase = Purchase.new(purchase_params)
    @purchase.listing = @listing
    @purchase.user = current_user
    start_time = DateTime.strptime(params[:purchase][:start_time], '%Y-%m-%d')
    finish_time = DateTime.strptime(params[:purchase][:finish_time], '%Y-%m-%d')
    date_diff = finish_time - start_time
    # TODO: Add confirmation page to create
    @purchase.total_cost = @listing.price * date_diff.to_i
    if @purchase.save
      redirect_to listing_purchase_path(@listing, @purchase)
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
    params.require(:purchase).permit(:start_time, :finish_time)
  end
end
