// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require turbolinks
//= require materialize-sprockets
//= require jquery.validate
//= require generators
//= require dexterityio
//= require_tree .

document.addEventListener('turbolinks:load', function() {
  var $body = $("body")
  var controller = $body.data("controller").replace(/\//g, "_");
  var action = $body.data("action");

  var activeController = app[controller];

  if (activeController !== undefined) {
    if ($.isFunction(activeController.init)) {
      activeController.init();
    }

    if ($.isFunction(activeController[action])) {
      activeController[action]();
    }
  }
});