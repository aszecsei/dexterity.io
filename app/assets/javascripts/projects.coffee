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
    # $("#projects-row").append(generateProjectCard("Dynamic Project #{num}", "<p>Description for project #{num}</p><p>Last worked on: Never.</p>", "#", "#", "#")) for num in [1..10]
    $('.modal').modal()
    $( '#add' ).validate
      rules:
        title:
          required: true
          minlength: 5
        description:
          required: true
      messages:
        title:
          minlength: "Enter at least 5 characters"
      errorElement: 'div'
      errorPlacement: (error, element) ->
        placement = $(element).data('error')
        if placement
          $(placement).append error
        else
          error.insertAfter element
        return
    $("#add").submit (e) ->
      console.log("Boo!")
      url = "/api/projects"
      $.ajax
        type: 'POST'
        headers: {"Authorization": "Token token=" + $("#token").val()}
        url: url
        data: $("#add").serialize()
        success: (data) ->
          $("#projects-row").append(generateProjectCard(data.name, data.description, "/projects/#{data.id}", "#", "#"))
          $("#addModal").modal('close');
          return
        error: (req, msg, stat) ->
          console.log(req)
          response = JSON.parse(req.responseText)
          errorsArr = (msg.detail for msg in response.errors)
          errorsHTML = errorsArr.join("\n")
          alert(errorsHTML)
          # $("#errorMsg").html(errorsHTML)
          return
      e.preventDefault()
      
      return
    return

this.app.projects = new ProjectsController