import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import { animateClaim } from './animateClaim';

animateClaim();
initMapbox();

mapboxgl.accessToken = 'pk.eyJ1Ijoic2lydGF5bG9yODgiLCJhIjoiY2p2N3ppaTI0MDFzZzQ2bW01MmZ2MGFhbCJ9.qbFjjsDDBjZKLpOCwWIpyg';

const form = document.querySelector("#search-form");
const input = document.querySelector("#searchform_address");
const baseUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
const endUrl = `.json?access_token=${mapboxgl.accessToken}`;

const sendRequest = (url) => {
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      const coords = data.features.map(elem => elem.geometry.coordinates);
      form.dataset.latitude = coords[0][0]
      form.dataset.longitude. = coords[0][1]
    });
};

form.addEventListener('submit-search', (event) => {
  const query = encodeURI(input.value);
  const url = `${baseUrl}${query}${endUrl}`;
  sendRequest(url);
});
