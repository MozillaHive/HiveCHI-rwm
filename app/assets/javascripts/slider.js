$( "#slider-1" ).on( 'change', function( event ) {
   var val = $("#slider-1").val();
   if(val == 1){
        $("#hint").empty();
        $("#hint").append("car");
   }else if(val == 2){
        $("#hint").empty();
        $("#hint").append("bike");
   }else if(val == 3){
        $("#hint").empty();
        $("#hint").append("public transportation");
   }

});

var refresh = function (e) {
    $sliderText.text(text[$('#rideOption').slider('value')]);
};
$(function () {
    $('#rideOption').slider({
        min: 1,
        max: 3,
        slide: refresh,
        change: refresh
    });
});