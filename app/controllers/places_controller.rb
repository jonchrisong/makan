class PlacesController < ApplicationController
  def index

    @places = Place.all.order("created_at desc").paginate(page: params[:page], per_page: 3)
  end

  def new
    @place = Place.new
  end

  def create
    Place.create(place_params)
    redirect_to root_path
  end

private

def place_params
  params.required(:place).permit(:name, :description, :address)
end




end
