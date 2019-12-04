class Map < ApplicationRecord
  validates :lat, presence: true
  validates :lng, presence: true
  validates :state, presence: true
  validates :population, presence: true
  validates :abbreviation, presence: true

  def build_geojson {
        type: "Feature",
        geometry: {
            type: "Point",
            coordinates: [
            lng,
            lat]
        },
        properties: {
            id: id,
            state: state,
            population: population,
            abbreviation: abbreviation
        }
    }
  end

  def self.attributable_params
    [
      :lat,
      :lng,
      :state,
      :population,
      :abbreviation
    ]
  end

end
