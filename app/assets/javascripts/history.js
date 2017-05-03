function initMap(mapid, center_lat, center_lng) {
  var center = {lat: center_lat, lng: center_lng};
  var map = new google.maps.Map(document.getElementById(mapid), {
    zoom: 4,
    center: center
  });
  return map;
}
function addMarker(map, lat, lng, icon_path, title){
  var position = {lat: lat, lng: lng};
  var marker = mkMarkerWithIcon(map, position, icon_path, title);
  return marker;
}
function mkInfoWindow(info) {
  var infowindow = new google.maps.InfoWindow({
    content: info
  });
  return infowindow;
}
function addInfoToMarker(marker, infoWindow) {
  marker.addListener('click', function() {
    infoWindow.open(marker.getMap(), marker);
  });
  return marker;
}
function drawPath(map, coordinates) {
  var flightPath = new google.maps.Polyline({
    path: coordinates,
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });
  flightPath.setMap(map);
}
function mkIcon(icon_path){
    return {
        url: icon_path, // url
        scaledSize: new google.maps.Size(20, 20), // scaled size
        //origin: new google.maps.Point(0,0), // origin
        //anchor: new google.maps.Point(0, 0) // anchor
    }
}
function mkMarkerWithIcon(map, latlng, icon_path, title) {
    return new google.maps.Marker({
        position: latlng,
        map: map,
        icon: mkIcon(icon_path),
        title: title,
        optimized: false
    });
}

var numDeltas = 200;
var delay = 15; //milliseconds
function transition(marker, from, to){
    var i = 0;
    var deltaLat = (to.lat - from.lat)/numDeltas;
    var deltaLng = (to.lng - from.lng)/numDeltas;
    moveMarker(marker, from, deltaLat, deltaLng, i);
}

function moveMarker(marker, from, deltaLat, deltaLng, i){
    from.lat += deltaLat;
    from.lng += deltaLng;
    var latlng = new google.maps.LatLng(from.lat, from.lng);
    marker.setPosition(latlng);
    if(i!=numDeltas){
        i++;
        setTimeout(function() {
          moveMarker(marker, from, deltaLat, deltaLng, i);
        }, delay);
    }
}
