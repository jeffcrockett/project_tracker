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
// For bootstrap:
//= require jquery3
//= require popper
//= require bootstrap-sprockets
// 
// For searchable dropdowns:
//= require select2
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


// Convert select tags to searchable ones
$(document).on("turbolinks:load", function(){
  $(".data-searchable").select2({
      theme: "bootstrap"
  });
});

// Hide elements that should be initially hidden
$(document).on("turbolinks:load", function(){
  $(".data-start-hidden").hide();
});

// Handle a selection for the Product select list
$(document).on("turbolinks:load", function(){
  $("#prod_select").on("select2:select", function(e){
    if(e.params.data.text === "Add new product") {
      $("#prod_name").val("")
    } else {
      $("#prod_name").val(e.params.data.text)
    }
    let fields = e.params.data.id.split("|")
    $("#prod_price").val(fields[1])
    $("#prod_cogs").val(fields[2])
  });
});

