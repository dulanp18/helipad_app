class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @listing = Listing.find(params[:listing_id])
    @purchase = Purchase.find(params[:purchase_id])
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @purchase = Purchase.find(params[:purchase_id])
    @review = Review.new(review_params)
    @review.purchase = @purchase
    if @review.save
      @purchase.save
      redirect_to listing_purchase_path(@listing, @purchase)
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @purchase = @review.purchase
    @listing = @purchase.listing
    @review.destroy
    redirect_to listing_purchase_path(@listing, @purchase)
  end

end

private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
