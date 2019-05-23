import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import { animateClaim } from './animateClaim';

animateClaim();
initMapbox();

const addToolButton = document.querySelector("#add-tool");
const baseUrl = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
const endUrl = `.json?access_token=${ENV['MAPBOX_API_KEY']}`;

const sendRequest = (url) => {
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      const results = data.features;
      const coords = results.map(elem => elem.geometry.coordinates);
      addToolButton.dataset.lng = coords[0][0]
      addToolButton.dataset.lat = coords[0][1]
    });
};

addToolButton.addEventListener('submit', (event) => {
  const query = encodeURI(current_user.address);
  const url = `${baseUrl}${query}${endUrl}`;
  sendRequest(url);
});
