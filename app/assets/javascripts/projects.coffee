# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class ProjectsController
  show: ->
    $(document).on 'turbolinks:load', ->
      $('ul.tabs').tabs()
      return
    return

  index: ->
    $("#projects-row").append(generateProjectCard("Dynamic Project #{num}", "<p>Description for project #{num}</p><p>Last worked on: Never.</p>", "#", "#", "#")) for num in [1..10]
    $('.modal').modal()
    $( '#formValidate' ).validate
      rules:
        title:
          required: true
          minlength: 5
        description:
          required: true
          email: true
      messages:
        title:
          minlength: "Enter at least 5 characters"
        description:
          email: "Enter a description"
      errorElement: 'div'
      errorPlacement: (error, element) ->
        placement = $(element).data('error')
        if placement
          $(placement).append error
        else
          error.insertAfter element
        return
    return

this.app.projects = new ProjectsController