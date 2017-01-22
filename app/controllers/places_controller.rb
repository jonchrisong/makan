class PlacesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]


  def index

    @places = Place.all.order("created_at desc").paginate(page: params[:page], per_page: 3)
  end

  def new
    @place = Place.new
  end

  def create
    @place = current_user.places.create(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @place = Place.find(params[:id])
  end

  def edit
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render file: Rails.root.join('public', 'not_found.html.erb'), status: :not_found, layout: false
    end
  end

  def update
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render file: Rails.root.join('public', 'not_found.html.erb'), status: :not_found, layout: false
    end
    @place.update_attributes(place_params)
    if @place.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place = Place.find(params[:id])
    if @place.user != current_user
      return render file: Rails.root.join('public', 'not_found.html.erb'), status: :not_found, layout: false
    end
    @place.destroy
    redirect_to root_path
  end



  private

  def place_params
    params.required(:place).permit(:name, :description, :address)
  end




end
