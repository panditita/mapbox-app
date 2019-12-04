class GeojsonBuilder < ApplicationRecord
    validates :lat, presence: true
    validates :lng, presence: true
    validates :state, presence: true
    validates :population, presence: true
    validates :abbreviation, presence: true

    def build_place(place, geojson)
        geojson << {
            type: "Feature",
            geometry: {
                type: "Point",
                coordinates: [
                    place.lng,
                    place.lat
                ],
            }
            properties: {
                state: place.name,
                population: place.population,
                abbreviation: place.abbreviation,
                marker-symbol: 'circle',
                marker-color: "",
                marker-size: "medium"

            }
        }
        
    end
end
