import mapboxgl from "mapbox-gl";
import * as ajax from './ajax';

const loadMap = () => {
  const mapContainer = document.getElementById("custom-map");

  if (mapContainer) {
      var map = mapSetup(mapContainer);
      map.on('load', renderPlaces)
  }
};

const mapSetup = function(){
    mapboxgl.accessToken =
    "pk.eyJ1IjoiZXR6YWxpIiwiYSI6ImNrM2lsdHhkNjA3NWQza28xM3JqcmRhNG0ifQ.PlTOfeKllnAH4Pn9ppkZ_Q";
  return new mapboxgl.Map({
    container: "custom-map",
    style: "mapbox://styles/etzali/ck3r9cmoc07gj1cmsddt1oixg/draft",
    center: [-99.601283, 24.103338],
    zoom: 5.0
  });
}

const renderPlaces = () => {
  ajax.getData(("api/data.json"), (data) => {
    const geojson = $.parseJSON(data);
    map.featureLayer.setGeoJSON({
      type: "FeaturedCollection",
      features: geojson
    });
    addPlacesPopups(map);
  });
}

const addPlacesPopups = map => {
  map.addLayer.on("layer-add", e => {
    const marker = e.marker;
    const properties = marker.feature.properties;
    const popupContent =
      '<div class="marker-popup">' +
      "<h3>" +
      properties.state +
      "</h3>" +
      "<h4>" +
      properties.abbreviation +
      "</h4>" +
      "<h4>" +
      properties.population +
      "</h4>" +
      "</div>";
    marker.bindPopup(popupContent, { closeButton: false, minWidth: 300 });
  });
}

  /*

  import mapboxgl from "mapbox-gl";
import * as ajax from './ajax';

const loadCustomMap = () => {
  const map = document.getElementById("custom-map");
  console.log('te consegui')
  if (map) {
      map = mapSetup(map)
      map.on('load', ()=>{
      renderPlaces(map)
     });
  }
};

const mapSetup = () => {
    mapboxgl.accessToken =
    "pk.eyJ1IjoiZXR6YWxpIiwiYSI6ImNrM2lsdHhkNjA3NWQza28xM3JqcmRhNG0ifQ.PlTOfeKllnAH4Pn9ppkZ_Q";
  const map = new mapboxgl.Map({
    container: "custom-map",
    style: "mapbox://styles/etzali/ck3r9cmoc07gj1cmsddt1oixg/draft",
    center: [-99.601283, 24.103338],
    zoom: 5.0
  });
  console.log('donde esta el mapa')

}

const renderPlaces = (map) => {

  $.ajax.getData(("api/data.json"), (data) => {
    const geojson = $.parseJSON(points);
    map.featureLayer.setGeoJSON({
      type: "FeaturedCollection",
      features: geojson
    });
    addPlacesPopups(map);
  }
  });


  addPlacesPopups = map => {
    map.addLayer.on("layer-add", e => {
      const marker = e.marker;
      const properties = marker.feature.properties;
      const popupContent =
        '<div class="marker-popup">' +
        "<h3>" +
        properties.state +
        "</h3>" +
        "<h4>" +
        properties.abbreviation +
        "</h4>" +
        "<h4>" +
        properties.population +
        "</h4>" +
        "</div>";
      marker.bindPopup(popupContent, { closeButton: false, minWidth: 300 });
    });
  }
}
/*
    const expression = ['match', ['get', 'id']]

    //Calculate color for each state based on population
    data.forEach((row) => {
        const maxValue = 17363387

        const green = (row['population']/maxValue) * 255;
        const colour = "rgba("+ 0 + "," + green + "," + 0 + ", 1)";
        expression.push(row['id'], colour);
    })

    // if there's not data  
    expression.push("rgba(0,0,0,0)");

    // add layer with data
    map.addLayer({
        'id': 'states-join',
        'type': 'circle',
        'source': 'states',
        'source-layer': 'states',
        'paint': {
            'circle-radius': {
                'base': 1.75,
                'stops': [[12, 2], [22, 180]]
                },
            'circle-color': expression
        }
    }, 'waterway-label')
};

  
 ajax.getData("api/data.json"), (data) => {
        mapData.addSymbol

    }  success: places => {
        const geojson = $.parseJSON(places);
        map.featureLayer.setGeoJSON({
          type: "FeaturedCollection",
          features: geojson
        });
        addPlacesPopups(map);
      },
      error: () => {
        alert("Could not load the places");
      }

addPlacesPopups = map => {
  map.addLayer.on("layer-add", e => {
    const marker = e.marker;
    const properties = marker.feature.properties;
    const popupContent =
      '<div class="marker-popup">' +
      "<h3>" +
      properties.state +
      "</h3>" +
      "<h4>" +
      properties.abbreviation +
      "</h4>" +
      "<h4>" +
      properties.population +
      "</h4>" +
      "</div>";
    marker.bindPopup(popupContent, { closeButton: false, minWidth: 300 });
  });
};
document.addEventListener("turbolinks:load", loadCustomMap); // need this to run javascript on rails


 ajax.getData("api/data.json"), (data) => {
        mapData.addSymbol

    }  success: places => {
        const geojson = $.parseJSON(places);
        map.featureLayer.setGeoJSON({
          type: "FeaturedCollection",
          features: geojson
        });
        addPlacesPopups(map);
      },
      error: () => {
        alert("Could not load the places");
      }

addPlacesPopups = map => {
  map.addLayer.on("layer-add", e => {
    const marker = e.marker;
    const properties = marker.feature.properties;
    const popupContent =
      '<div class="marker-popup">' +
      "<h3>" +
      properties.state +
      "</h3>" +
      "<h4>" +
      properties.abbreviation +
      "</h4>" +
      "<h4>" +
      properties.population +
      "</h4>" +
      "</div>";
    marker.bindPopup(popupContent, { closeButton: false, minWidth: 300 });
  });
};*/
document.addEventListener("turbolinks:load", loadMap); // need this to run javascript on rails
