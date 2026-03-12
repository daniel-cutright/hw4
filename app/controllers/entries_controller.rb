class EntriesController < ApplicationController

  def new
    if @current_user == nil
      flash["notice"] = "Please login first."
      redirect_to "/login"
    end
  end

  def create
    if @current_user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = session["user_id"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      flash["notice"] = "Please login first."
      redirect_to "/login"
    end
  end

end