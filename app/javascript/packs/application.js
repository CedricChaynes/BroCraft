import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import { animateClaim } from './animateClaim';

animateClaim();
initMapbox();
