// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.mobile
//= require_tree .
//= require 'icheck'
//= require 'icheck.js'

function icheck() {
  if($(".fancy_radio").length > 0){
    $(".fancy_radio").each(function(){
      var $el  = $(this);
      var skin = ($el.attr('data-skin')  !== undefined) ? "_" + $el.attr('data-skin') : "",
      color    = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
      var opt  = {
        checkboxClass: 'icheckbox' + skin + color,
        radioClass: 'iradio' + skin + color,
      }
      console.log($el);
      // $el.icheck(opt);
    });
  }
}

$(function(){
    icheck();
})