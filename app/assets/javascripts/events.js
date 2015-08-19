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
calcedTimes = {
}
arriveLatLng = new google.maps.LatLng(arriveLocation.latitude, arriveLocation.longitude);

var aspect_ratio = Math.min(1,$(window).height()/$(window).width()-.1)


setTimeout(function(){
   initializeMap()
   $("#map-canvas").height($("#map-canvas").width()*aspect_ratio)
},1)

}

function calcRoute(selectedMode,directionsService,depLatLng) {
  if (!calcedTimes[JSON.parse($("#leave_loc").val()).id.toString()]){
    calcedTimes[JSON.parse($("#leave_loc").val()).id.toString()] = {}
  }
  if (calcedTimes[JSON.parse($("#leave_loc").val()).id.toString()][selectedMode]){
    printTime (calcedTimes[JSON.parse($("#leave_loc").val()).id.toString()][selectedMode],selectedMode)
  }
  else{
  var request = {
      origin: depLatLng,
      destination: arriveLatLng,
      travelMode: google.maps.TravelMode[selectedMode],
      transitOptions:{
        arrivalTime: arrivetime
      }
  }
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
        calcedTimes[JSON.parse($("#leave_loc").val()).id.toString()][selectedMode] = response.routes[0].legs[0].duration.text
        printTime (calcedTimes[JSON.parse($("#leave_loc").val()).id.toString()][selectedMode],selectedMode)
   }
 });
}
}

function calcTravelTimes(){
     leaveLoc = JSON.parse($("#leave_loc").val())
     $("#leave_loc").children()[0].disabled = true
     $("#leave_loc").children()[0].style["display"] = "none"
     var departureLatLng =  new google.maps.LatLng(leaveLoc.latitude, leaveLoc.longitude);
     directionsService = new google.maps.DirectionsService()
     calcRoute("TRANSIT",directionsService,departureLatLng)
     calcRoute("BICYCLING",directionsService,departureLatLng)
     calcRoute("WALKING",directionsService,departureLatLng)
 }
function initializeMap() {
  geocoder = new google.maps.Geocoder();
  var mapOptions = {
    zoom: 15,
    center: arriveLatLng
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  var marker = new google.maps.Marker({
          map: map,
          position: arriveLatLng
      });
}
function printTime(text,tmode){
  document.getElementById(tmode).innerHTML = modePrefix[tmode].concat(text)
}
