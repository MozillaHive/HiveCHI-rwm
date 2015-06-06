var text = {
    1: "bad",
    2: "okay",
    3: "better"
};
var $sliderText = $('#hint');

var refresh = function (e) {
    $sliderText.text(text[$('#slider-1').slider('value')]);
};
$(function () {
    $('#slider-1').slider({
        min: 1,
        max: 3,
        slide: refresh,
        change: refresh
    });
    refresh();
});