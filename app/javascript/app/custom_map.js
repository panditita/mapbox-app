import mapboxgl from "mapbox-gl";
import * as ajax from "./ajax";


const loadMap = () => {
  const mapContainer = document.getElementById("custom-map");

  if (mapContainer) {
    var map = mapSetup(mapContainer);
    map.on("load", renderPlaces(map));
    console.log(`${map} adentro de Loadmap`);
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
};

const renderPlaces = map => {
  function checkIfMapboxStyleIsLoaded() {
    if (map.isStyleLoaded()) {
      return true; // When it is safe to manipulate layers
    } else {
      return false; // When it is not safe to manipulate layers
    }
  }

  function swapLayer() {
    var check = checkIfMapboxStyleIsLoaded();
    if (!check) {
      // It's not safe to manipulate layers yet, so wait 200ms and then check again
      setTimeout(function() {
        swapLayer();
      }, 200);
      return;
    }

    const layerId = "states";
    const data = "./api/data.json";
    console.log(`${data} adentro de renderPlaces`);

    map.addSource(layerId, {
      "type": "geojson",
      "data": data
    });
    console.log(`${data} despues de add source`);

    map.addLayer({
      "id": layerId,
      "type": "circle",
      "source": layerId,
      'paint': {
        'circle-radius': 6,
        'circle-color': '#B42222'
        }
    });
    console.log(`${data} despues de add layer`);

  }
  swapLayer();
};

document.addEventListener("turbolinks:load", loadMap); // need this to run javascript on rails
