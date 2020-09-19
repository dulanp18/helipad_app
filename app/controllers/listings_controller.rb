class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @user = current_user
    @listings = if params[:query].present?
                  Listing.search_by_title(params[:query])
                elsif params[:price_range].present?
                  Listing.where("price <= #{params[:price_range]}")
                else
                  Listing.all
                end
    @markers = @listings.geocoded.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { listing: listing })
      }
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @user = current_user
    @purchases = @listing.purchases
    @reviews = []
    @purchases.each do |purchase|
      if purchase.review
        @reviews << purchase.review
      end
    end

    @markers = [{
      lat: @listing.geocode[0],
      lng: @listing.geocode[1],
      infoWindow: render_to_string(partial: "info_window", locals: { listing: @listing })
    }]
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to my_listings_path
  end

  def my_listings
    @user = current_user
    @listings = Listing.where(user_id: @user.id)
        @markers = @listings.geocoded.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { listing: listing })
      }
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :price, :address, :photo)
  end
end
