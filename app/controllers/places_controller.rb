class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @entries = Entry.where({ "place_id" => @place["id"], "user_id" => session["user_id"] })
  end

  def new
    if @current_user == nil
      flash["notice"] = "Please login first."
      redirect_to "/login"
    end
  end

  def create
    if @current_user != nil
      @place = Place.new
      @place["name"] = params["name"]
      @place.save
      redirect_to "/places"
    else
      flash["notice"] = "Please login first."
      redirect_to "/login"
    end
  end

end
