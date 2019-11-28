class MapController < ApplicationController
  def index
    @maps = Map.all
    @geojson = Array.new
    build_geojson(place, @geojson)
    end

    respond_to do | format |
      format.hml
      format.json { render json: @geojson}
  end

  def build_geojson (place, geojson)
    places.each do | place |
      geojson << GeojsonBuilder.build_place(place)
    end
  end
  
end
