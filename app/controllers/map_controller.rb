class MapController < ApplicationController
  def index
    @maps = Map.all.map do | m | m.build_geojson end
    render json: {type: "FeaturedCollection", features: @maps  }
  end
end
