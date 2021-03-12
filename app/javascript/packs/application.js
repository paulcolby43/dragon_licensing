// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


//import "jquery";
//import "popper.js";
//import "bootstrap";
//import "../stylesheets/application";

import * as bootstrap from 'bootstrap'
import "../stylesheets/application"
import "@fortawesome/fontawesome-free/css/all"

// Flatpickr datepicker stuff
import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css"

document.addEventListener("turbolinks:load", function() {
  //  flatpickr(".datepicker", {})
  flatpickr(".flatpickr", {
    //minDate: "today",
    altInput: true,
  });
})

document.addEventListener("turbolinks:before-cache", function() {
  $(".flatpickr").each(function(){ 
    this._flatpickr.destroy()
   })
})


document.addEventListener("DOMContentLoaded", function(event) {
  
  var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
  })

  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
  
});

var jQuery = require('jquery')
// include jQuery in global and window scope (so you can access it globally)
// in your web browser, when you type $('.div'), it is actually refering to global.$('.div')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;