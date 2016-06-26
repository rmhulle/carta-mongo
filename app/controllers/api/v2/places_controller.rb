class Api::V2::PlacesController < ApplicationController

  def index
    @places = Place.where(visible: true)
  end



end
