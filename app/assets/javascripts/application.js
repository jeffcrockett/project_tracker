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

// Handle a selection for the Project select list
$(document).on("turbolinks:load", function () {
  $("#proj_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      window.location = "/projects/" + e.params.data.id + "/edit"
    }
  });
});

// Handle a selection for the Company select list
$(document).on("turbolinks:load", function () {
  $("#comp_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      window.location = "/companies/" + e.params.data.id + "/edit"
    }
  });
});

// Handle a selection for the Registration select list
$(document).on("turbolinks:load", function () {
  $("#reg_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      window.location = "/registrations/" + e.params.data.id + "/edit"
    }
  });
});

// Handle a selection for the Distributor select list
$(document).on("turbolinks:load", function () {
  $("#dist_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      window.location = "/distributors/" + e.params.data.id + "/edit"
    }
  });
});

// Handle a selection for the Registration select list
$(document).on("turbolinks:load", function () {
  $("#reg_proj_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      $('#reg_form_id').val(e.params.data.id.toString())
    }
  });
});

// Handle a selection for the shipment product select list
$(document).on("turbolinks:load", function () {
  $("#ship_prod_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      $('#ship_prod_form_id').val(e.params.data.id.toString())
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

// Handle the "shipment delete" button
$(document).on("turbolinks:load", function () {
  $("#btn_ship_delete").on("click", function (e) {
    let id = $("#ship_del_select").val();
    if (id != "0") {
      window.location = "/shipments/" + id + "/delete"
    }
  });
});

// Handle the "project delete" button
$(document).on("turbolinks:load", function () {
  $("#btn_proj_delete").on("click", function (e) {
    let id = $("#proj_del_select").val();
    if (id != "0") {
      window.location = "/projects/" + id + "/delete"
    }
  });
});

// Handle the "distributor delete" button
$(document).on("turbolinks:load", function () {
  $("#btn_dist_delete").on("click", function (e) {
    let id = $("#dist_del_select").val();
    if (id != "0") {
      window.location = "/distributors/" + id + "/delete"
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

// Handle a click on the edit shipment button
$(document).on("turbolinks:load", function () {
  $(".edit-shipment").on("click", function(e) {
    window.location = "/shipments/" + e.target.id + "/edit"
  })
})

// Handle a click on the delete shipment button
$(document).on("turbolinks:load", function () {
  $(".delete-shipment").on("click", function (e) {
    window.location = "/shipments/" + e.target.id + "/delete"
  })
})

// Handle a click on the add shipment button
$(document).on("turbolinks:load", function () {
  $(".add-shipment").on("click", function (e) {
    window.location = "/shipments/" + e.target.id + "/new"
  })
})

// Handle a click on the shift shipment dates button
$(document).on("turbolinks:load", function () {
  $(".shift-dates").on("click", function (e) {
    window.location = "/projects/" + e.target.id + "/getshift"
  })
})

// Get values for date shift
$(document).on("turbolinks:load", function () {
  $(".get-shift").on("click", function (e) {
    let id = e.target.id;
    let days = $("#shiftDays").val() ? $("#shiftDays").val() : "0";
    let weeks = $("#shiftWeeks").val() ? $("#shiftWeeks").val() : "0";
    let months = $("#shiftMonths").val() ? $("#shiftMonths").val() : "0";
    window.location = "/projects/shift/" + id + "/" + days + "/" + weeks + "/" + months  
  })
})

// Handle a click on a clone shipment button
$(document).on("turbolinks:load", function () {
  $(".clone-shipment").on("click", function (e) {
    window.location = "/projects/" + e.target.id + "/getclone"
  })
})

// Get values for shipment clone
$(document).on("turbolinks:load", function () {
  $(".get-clone").on("click", function (e) {
    let id = e.target.id;
    let howMany = $("#cloneHowmany").val() ? $("#cloneHowmany").val() : "0";
    let days = $("#cloneDays").val() ? $("#cloneDays").val() : "0";
    let weeks = $("#cloneWeeks").val() ? $("#cloneWeeks").val() : "0";
    let months = $("#cloneMonths").val() ? $("#cloneMonths").val() : "0";
    window.location = "/projects/clone/" + id + "/" + howMany + "/" + days + "/" + weeks + "/" + months  
  })
})

// Handle a selection for the Shipment select list
$(document).on("turbolinks:load", function () {
  $("#ship_select").on("select2:select", function (e) {
    if (e.params.data.id != "0") {
      window.location = "/shipments/" + e.params.data.id + "/edit"
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

// Handle the "company delete" button
$(document).on("turbolinks:load", function () {
  $("#btn_comp_delete").on("click", function (e) {
    let id = $("#comp_del_select").val();
    if (id != "0") {
      window.location = "/companies/" + id + "/delete"
    }
  });
});

// Handle the "registration delete" button
$(document).on("turbolinks:load", function () {
  $("#btn_reg_delete").on("click", function (e) {
    let id = $("#reg_del_select").val();
    if (id != "0") {
      window.location = "/registrations/" + id + "/delete"
    }
  });
});

// Handle a selection on the choice list in View Registrations by Company
$(document).on("turbolinks:load", function () {
  $("#get_company").on("select2:select", function (e) {
    let val = $("#get_company").val();
    if (val != "0") {
      window.location = "/registrations/" + val + "/forcompany";
    }
  });
});

