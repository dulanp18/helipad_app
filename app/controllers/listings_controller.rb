class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index :show

  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.save
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing = Listing.update(listing_params)
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to listings_path
  end

  private

  def listing_params
    params.require(:title, :description, :price, :user_id)
  end
end
