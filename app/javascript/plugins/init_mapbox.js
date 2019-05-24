import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const initMapbox = () => {
  const mapElements = document.querySelectorAll("[id^='map']");
  if (mapElements) { // only build a map if there's a div#map to inject into
    mapElements.forEach((mapElement) => {
      const markers = JSON.parse(mapElement.dataset.markers);

      mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
      const map = new mapboxgl.Map({
        container: `map${mapElement.dataset.toolId}`,
        style: 'mapbox://styles/mapbox/streets-v10',
        center: markers[0],
        zoom: 12
      });

      markers.forEach((marker) => {
        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .addTo(map);
      });

      fitMapToMarkers(map, markers);
    })
  };
};

export { initMapbox };
