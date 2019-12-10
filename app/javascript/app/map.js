import mapboxgl from "mapbox-gl";

mapboxgl.accessToken =
  "pk.eyJ1IjoiZXR6YWxpIiwiYSI6ImNrM2lsdHhkNjA3NWQza28xM3JqcmRhNG0ifQ.PlTOfeKllnAH4Pn9ppkZ_Q";

const loadMap = () => {
  const map = document.getElementById("map");

  if (map) { // check if container exists

    const map = new mapboxgl.Map({
      container: "map", //container id
      style: "mapbox://styles/etzali/ck3ilu9zo00pr1conq4cmwhs5/draft",
      center: [-99.139418, 19.388165],
      zoom: 11.04
    });
  }
};

document.addEventListener('turbolinks:load', loadMap) // need this to run javascript on rails