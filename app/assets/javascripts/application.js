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


//= require bootstrap-datepicker 


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
    if(e.params.data.id != "0") {
      window.location = "/products/" + e.params.data.id + "/edit"
    }
  });
});

// Handle the "product delete" button
$(document).on("turbolinks:load", function () {
  $("#btn_prod_delete").on("click", function (e) {
    let id = $("#prod_del_select").val();
    if (id != "0") {
      window.location = "/products/" + id + "/delete"
    }
  });
});

// Handle a selection for the User select list
$(document).on("turbolinks:load", function () {
  $("#user_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      window.location = "/users/" + e.params.data.id + "/edit"
    }
  });
});

// Handle the "user delete" button
$(document).on("turbolinks:load", function () {
  $("#btn_user_delete").on("click", function (e) {
    let id = $("#user_del_select").val();
    if (id != "0") {
      window.location = "/users/" + id + "/delete"
    }
  });
});

//Handle selection for product select list
$(document).on("turbolinks:load", function () {
  $("#reg_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      $("#reg_proj_id").val(e.params.data.id)
      // window.location = "/users/" + e.params.data.id + "/edit"
    }
  });
});