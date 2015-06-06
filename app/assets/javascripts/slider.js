$( "#slider-1" ).on( 'change', function( event ) {
   var val = $("#slider-1").val();
   if(val == 1){
        $("#hint").empty();
        $("#hint").append("beschissen");
   }else if(val == 2){
        $("#hint").empty();
        $("#hint").append("naja");
   }else if(val == 3){
        $("#hint").empty();
        $("#hint").append("passt");
   }else if(val == 4){
        $("#hint").empty();
        $("#hint").append("fett");
   }else if(val == 5){
        $("#hint").empty();
        $("#hint").append("geilo");
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