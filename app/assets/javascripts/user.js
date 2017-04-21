function fitBound(mapState){
    var bounds = new google.maps.LatLngBounds();
    mapState.markerStates.forEach(function(ms){
        bounds.extend(ms.marker.getPosition());
    });
    mapState.map.fitBounds(bounds);    
}
function findMarkerState(mapState, markerId){
	var states = mapState.markerStates.filter(function(ms){
		return ms.id == markerId;
	});
	return states[0];
}
function mkMarker(map, latlng){
	return new google.maps.Marker({
        position: latlng,
        map: map,
        title: "Your current location!"
    });
}
function mkMap(domid, center){
	var myOptions = {
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    return new google.maps.Map(document.getElementById(domid), myOptions);
}
function mkLatLng(lat, lng){
	return new google.maps.LatLng(lat, lng);
}
function initialize(mapState, mapId, centerPos, posMarkers) {        
    var center = mkLatLng(centerPos[0], centerPos[1]);  
    mapState.centerPos = centerPos;  
    mapState.map = mkMap(mapId, center);
    mapState.markerStates = posMarkers.map(function(pos){
    	return {
    		id: pos[0],
    		i: 0,
    		position: [pos[1], pos[2]],
    		marker: mkMarker(mapState.map, mkLatLng(pos[1], pos[2])),
    		deltaLat: 0,
    		deltaLng: 0
    	}
    });
    fitBound(mapState);
}

function subscribeChannel(channel, mapState, App){
	App.messages = App.cable.subscriptions.create(channel, { 
	  received: function(data){
	    var markerState = findMarkerState(mapState, data.position[0]);	    
        if (!!markerState) {
            var pos = [data.position[1], data.position[2]];
            mapState.centerPos = data.center;
            transition(mapState, markerState, pos);    
        }
	  }
	});
}
function transition(mapState, markerState, result){    
    markerState.i = 0;
    markerState.deltaLat = (result[0] - markerState.position[0])/mapState.numDeltas;
    markerState.deltaLng = (result[1] - markerState.position[1])/mapState.numDeltas;
    moveMarker(mapState, markerState);
}

function moveMarker(mapState, markerState){
    markerState.position[0] += markerState.deltaLat;
    markerState.position[1] += markerState.deltaLng;
    var latlng = mkLatLng(markerState.position[0], markerState.position[1]); 
    markerState.marker.setPosition(latlng);
    fitBound(mapState);
    if(markerState.i != mapState.numDeltas){
        markerState.i++;
        setTimeout(function(){
         moveMarker(mapState, markerState);
        }, mapState.delay);
    }
}

function resizeMap(domId){
  var h = window.innerHeight;
  var w = window.innerWidth;

  $(domId).width(w/2);
  $(domId).height(h-200);

}
function subscribeDomEvents(domId, mapState){
  google.maps.event.addDomListener(window, "resize", function() {
    var center = mapState.map.getCenter();
    resizeMap(domId);
    google.maps.event.trigger(mapState.map, "resize");
    mapState.map.setCenter(center);
  });
}

function initUsersState(usersState, users){
    usersState.users = users;
}
function renderUsersState(usersState, tableId){
    dom = "<table class='table'><thead><td>Email</td><td>Latitude</td><td>Longitude</td><td>View</td></thead><tbody>"
    dom += usersState.users.map(function(user){
        return "<tr><td>" + user.email + "</td><td>" + user.latitude + "</td><td>" + user.longitude + "</td><td>" + "<a href='/users/" + user.id + "'>View</a>" + "</td></tr>";
    });
    dom += "</tbody></table>";
    $(tableId).html(dom);
    
}