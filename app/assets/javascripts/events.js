
// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready( function() {
  $('.button-collapse').sideNav({
      menuWidth: 300, // Default is 240
      edge: 'right', // Choose the horizontal origin
      closeOnClick: true // Closes side-nav on <a> clicks, useful for Angular/Meteor
  });

    $('.scrollspy').scrollSpy();
     //on create_event_page? 
    if($('.toc-wrapper').length > 0){
      $('.toc-wrapper').pushpin({ offset: $('.toc-wrapper').offset().top });
      initializeAutocomplete();
    };

    if($('.edit-event-form').length > 0){
      initializeAutocomplete();
    }
    
    if($("#main-map-canvas").length > 0){
      getGeoDataMain('/api/v1/events/map');
    }

    if($("#single-map-canvas").length > 0){
      var eventId = $("#single-map-canvas").data("id")
      getGeoDataSingle('/api/v1/events/' + eventId + '/map');
    }
});


//Maps: Single map for event pages and main map on front page

  var map;
  var markers = [];
  var getGeoDataMain = function(url) {
    $.getJSON( url, function(json){
       initializeMainMap(json) 
    })
  };

  var getGeoDataSingle = function(url) {
    $.getJSON( url, function(json){
       initializeSingleMap(json) 
    })
  };
       


function initializeMainMap(json) {
  map = new google.maps.Map(document.getElementById("main-map-canvas"), {
    zoom: 12,
    center: new google.maps.LatLng(json.features[0].geometry.coordinates[1], json.features[0].geometry.coordinates[0])
  });


  for (var i = json.features.length - 1; i >= 0; i--) {
    var lat = json.features[ i ].geometry.coordinates[0]
    var lng = json.features[ i ].geometry.coordinates[1]
    var title = json.features[i].properties.title
    if(json.features[i].properties.eventpictures.length > 0){
      var mediumURL = json.features[i].properties.eventpictures[0].mediumURL
    }else{
      var mediumURL = ""
    };
    var description = json.features[i].properties.description
    var eventTime = json.features[i].properties.eventTime
    var latLng = new google.maps.LatLng(lng, lat)
    var marker = new google.maps.Marker({position: latLng, map: map, title: title, description: description, time: eventTime, photo: mediumURL})
    var infowindow = new google.maps.InfoWindow()
    google.maps.event.addListener(marker, 'click', function() {
      infowindow.setContent("<div class='infowindow'><img src=" + this.photo + ">" + "<br>" + this.title + ", " + "<br>"+ this.time)
      infowindow.open(map, this)
    });
    markers.push(marker)
  };
};

function initializeSingleMap(json) {
  map = new google.maps.Map(document.getElementById("single-map-canvas"), {
    zoom: 12,
    center: new google.maps.LatLng(json.features.geometry.coordinates[1], json.features.geometry.coordinates[0])
  });


    var lat = json.features.geometry.coordinates[0]
    var lng = json.features.geometry.coordinates[1]
    var title = json.features.properties.title
    var description = json.features.properties.description
    if(json.features.properties.eventpictures.length > 0){
      var thumb = json.features.properties.eventpictures[0].thumbURL
    }else{
      var thumb = ""
    };
    var latLng = new google.maps.LatLng(lng, lat)
    var marker = new google.maps.Marker({position: latLng, map: map, title: title, description: description, photo: thumb})
    marker.infowindow = new google.maps.InfoWindow({content: title + " " + "<img src=" + thumb + ">"});
    google.maps.event.addListener(marker, 'click', function() {   
      this.infowindow.open(map, this)
    });
    markers.push(marker)
  
};


//Autocomplete

var placeSearch, autocomplete;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initializeAutocomplete() {
  // Create the autocomplete object, restricting the search
  // to geographical location types.
  autocomplete = new google.maps.places.Autocomplete(
      (document.getElementById('autocomplete')),
      { types: ['geocode'] });
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    fillInAddress();
  });
}

// [START region_fillform]
function fillInAddress() {

  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();

  for (var component in componentForm) {
    document.getElementById(component).value = '';
    document.getElementById(component).disabled = false;
  }

  // Get each component of the address from the place details
  // and fill the corresponding field on the form.
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    if (componentForm[addressType]) {
      var val = place.address_components[i][componentForm[addressType]];
      document.getElementById(addressType).value = val;
    }
  }
}
// [END region_fillform]

// [START region_geolocation]
// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}
// [END region_geolocation]

// Test helper methods
testInfo = function(){
  document.getElementById("info-box").innerHTML = markers[0].title 
}

testInfoCount = function(){
  document.getElementById("info-box").innerHTML = markers.length 
}

testInfoWindow = function(){
  document.getElementById("info-box").innerHTML = markers[0].title + ", " + markers[0].time
}

