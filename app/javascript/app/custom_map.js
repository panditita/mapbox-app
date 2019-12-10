import mapboxgl from "mapbox-gl";
import * as ajax from './ajax';

const loadMap = () => {
  const mapContainer = document.getElementById("custom-map");

  if (mapContainer) {
      var map = mapSetup(mapContainer);
      map.on('load', renderPlaces(map));
        
      console.log(`${map} adentro de Loadmap`)
  }
};

const mapSetup = () => {
    mapboxgl.accessToken =
    "pk.eyJ1IjoiZXR6YWxpIiwiYSI6ImNrM2lsdHhkNjA3NWQza28xM3JqcmRhNG0ifQ.PlTOfeKllnAH4Pn9ppkZ_Q";
  return new mapboxgl.Map({
    container: "custom-map",
    style: "mapbox://styles/etzali/ck3r9cmoc07gj1cmsddt1oixg/draft",
    center: [-99.601283, 24.103338],
    zoom: 5.0
  });
}

const renderPlaces = (map) => {
  const layerId = "states";
  const data = "/api/data.json";

  console.log(`${map} adentro de renderPlaces`);

  map.addSource(layerId, {
    type: "geojson",
    url: data
  });

  map.addLayer(
    {
      id: layerId,
      type: "circle",
      source: data,
      "circle-color": "turquoise"
    }
  );

};


document.addEventListener("turbolinks:load", loadMap); // need this to run javascript on rails
