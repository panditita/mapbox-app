import mapboxgl from "mapbox-gl";
import * as ajax from './ajax';

const loadMap = () => {
  const mapContainer = document.getElementById("custom-map");

  if (mapContainer) {
      var map = mapSetup(mapContainer);
      map.on('load', renderPlaces);
        
      console.log(`${map} adentro de Loadmap`)
  }
};

const mapSetup = function(){
    mapboxgl.accessToken =
    "";
  return new mapboxgl.Map({
    container: "custom-map",
    style: "mapbox://styles/etzali/ck3r9cmoc07gj1cmsddt1oixg/draft",
    center: [-99.601283, 24.103338],
    zoom: 5.0
  });
}

const renderPlaces = () => {
  const layerId = "states";
  const data = "/api/data.json";

  map.addSource(layerId, {
    type: "geojson",
    url: data
  });

  map.addLayer(
    {
      id: layerId,
      type: "circle",
      source: data,
      "source-layer": data,
      paint: {
        "circle-radius": {
          base: 1.75,
          stops: [
            [12, 2],
            [22, 180]
          ]
        },
        "circle-color": "turquoise"
      }
    },
    "waterway-label"
  );

  console.log(`${map} adentro de renderPlaces`);
};


document.addEventListener("turbolinks:load", loadMap); // need this to run javascript on rails
