this.app ?= {}
$ ->
  $('.modal').modal()

$(document).on "turbolinks:load page:change", ->
  # Do Materialize-related setup
  console.log("Adding modals")
  
  $('ul.tabs').tabs()
  $('select').material_select()
  $('.parallax').parallax()
  
  # Run page-specific code
  $body = $("body")
  controller = $body.data("controller").replace(/\//g, "_")
  action = $body.data("action")

  activeController = app[controller]

  if (activeController != undefined)
    if ($.isFunction(activeController.init))
      activeController.init()

    if ($.isFunction(activeController[action]))
      activeController[action]()