class GeojsonBuilder < ApplicationRecord
    validates :lat, presence: true
    validates :lng, presence: true
    validates :state, presence: true
    validates :population, presence: true
    validates :abbreviation, presence: true

    def build_point(point, geojson)
        geojson << {
            type: "Feature",
            geometry: {
                type: "Point",
                coordinates: [
                    point.lng,
                    point.lat
                ],
            }
            properties: {
                state: point.name,
                population: point.population,
                abbreviation: point.abbreviation,
                marker-symbol: 'circle',
                marker-color: "",
                marker-size: "medium"

            }
        }
        
    end
end
