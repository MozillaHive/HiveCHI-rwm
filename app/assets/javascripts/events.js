/**
 * Created by tmorris on 8/2/15.
 */
function popularity_count(attendees) {
    for(var i=0; i<attendees; i++){
        $("img")
            .attr({"src": "default_person.jpg"});
    }
}

function event_show(){
	modePrefix = {
	BICYCLING: "Time by biking: ",
	TRANSIT: "Time by CTA: ",
	WALKING: "Time by walking: "
}
shown = {
	BICYCLING: false,
	TRANSIT: false,
	WALKING: false
}

var aspect_ratio = Math.min(1,$(window).height()/$(window).width()-.1)
function calcRoute(selectedMode,directionsService) {

  var request = {
      origin: leaveaddr,
      destination: arriveaddr,
      travelMode: google.maps.TravelMode[selectedMode],
      transitOptions:{
      	arrivalTime: arrivetime
      }
  }
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
    	if (!shown[selectedMode]){
     		time = response.routes[0].legs[0].duration.text
      		document.getElementById(selectedMode).innerHTML = modePrefix[selectedMode].concat(time)
      		shown[selectedMode] = true
      	}
   }
 });
}
setTimeout(function(){
  if(user){
	   directionsService = new google.maps.DirectionsService()
	   calcRoute("TRANSIT",directionsService)
	   calcRoute("BICYCLING",directionsService)
	   calcRoute("WALKING",directionsService)
   }
   initialize()
   codeAddress()
},1)
var geocoder;
var map;

function initialize() {
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(42, 1-87);
  var mapOptions = {
    zoom: 15,
    center: latlng
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  $("#map-canvas").height($("#map-canvas").width()*aspect_ratio)
}

function codeAddress() {
  geocoder.geocode( { 'address': arriveaddr}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });
    } else {
      $("#map-canvas").innerHTML = ('Geocode was not successful for the following reason: ' + status);
    }
  });
}
}

$( document ).ready(function() {
	$( "#event-type-toggles input[type=checkbox]" ).change(function() {
    	var eventsOfThisType = $( "#event-list li." + this.name );
        if ($( this ).is(":checked")) {
            eventsOfThisType.slideDown(100);
        } else {
            eventsOfThisType.slideUp(100);
        }
    });
});
