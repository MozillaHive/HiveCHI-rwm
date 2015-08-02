modePrefix = {
	BICYCLING: "Time by biking: ",
	TRANSIT: "Time by public transit: ",
	WALKING: "Time by walking: "
}
shown = {
	BICYCLING: false,
	TRANSIT: false,
	WALKING: false
}

function calcRoute(selectedMode,directionsService) {

  var request = {
      origin: leaveaddr.concat(" Chicago, IL"),
      destination: arriveaddr.concat(" Chicago, IL"),
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
	directionsService = new google.maps.DirectionsService()
	calcRoute("TRANSIT",directionsService)
	calcRoute("BICYCLING",directionsService)
	calcRoute("WALKING",directionsService)
},1)