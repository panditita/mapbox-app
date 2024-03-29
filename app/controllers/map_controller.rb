class MapController < ApplicationController
  def index
    @maps = Map.all.map 
    @geojson = Array.new
    build_geojson(@maps, @geojson)

    respond_to do |format|
      format.html
      format.json { render json: @geojson}
    end
  end

  def build_geojson(points, geojson)
    points.each do | point |
      geojson << GeojsonBuilder.build_point(point)
    end
  end


  private
  def json_response(object, status = :ok)
    render json: object, status: status
  end

end
 