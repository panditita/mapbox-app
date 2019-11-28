class GeojsonBuilder < ApplicationRecord
    def build_place(place, geojson)
        geojson << {
            type: "Feature",
            geometry: {
                type: "Point",
                coordinates: [
                    longitude,
                    latitude
                ],
            }
            properties: {
                state: place.name,
                population: place.population,
                marker-symbol: 'circle'
            }
        }
        
    end
    
end
