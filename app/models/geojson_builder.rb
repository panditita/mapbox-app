class GeojsonBuilder < ApplicationRecord
    def build_place(place, geojson)
        geojson << {
            type: "FeatureCollection",
            geometry: {
                type: "Point",
                coordinates: [
                    longitude,
                    latitude
                ],
            }
            properties: {
                neighborhood_name
            }
        }
        
    end
    
end
