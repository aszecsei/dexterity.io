# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class ProjectsController
  index: ->
    active = null
    # $("#projects-row").append(generateProjectCard("Dynamic Project #{num}", "<p>Description for project #{num}</p><p>Last worked on: Never.</p>", "#", "#", "#")) for num in [1..10]
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
        
    $(".editbtn").click (e) ->
      active = $(this).attr("data")
      $("#editModal").modal('open');
      url = "/api/project/"+active
      $.ajax
        type: 'GET'
        headers: {"Authorization": "Token token=" + $("#token").val()}
        url: url
        success: (data) ->
          $("#editname").attr("value",data.name)
          $("#editdescription").val(data.description)
          $('#textarea1').trigger('autoresize');
          console.log(data)
          Materialize.updateTextFields();
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
      
    $(".deletebtn").click (e)->
      active = $(this).attr("data")
      return
      
    $("#delete").submit (e) ->
      console.log("Boo!")
      url = "/api/project/"+active
      $.ajax
        type: 'DELETE'
        headers: {"Authorization": "Token token=" + $("#token").val()}
        url: url
        data: active
        success: (data) ->
          location.reload();
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
      
    $("#edit").submit (e) ->
      console.log("Boo!")
      url = "/api/project/"+active
      $.ajax
        type: 'PUT'
        headers: {"Authorization": "Token token=" + $("#token").val()}
        url: url
        data: $("#edit").serialize()
        success: (data) ->
          location.reload();
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

    $("#add").submit (e) ->
      console.log("Boo!")
      url = "/api/projects"
      $.ajax
        type: 'POST'
        headers: {"Authorization": "Token token=" + $("#token").val()}
        url: url
        data: $("#add").serialize()
        success: (data) ->
          $("#projects-row").append(generateProjectCard(data.name, data.description, "/projects/#{data.id}", "#editModal", "#deleteModal",data.id))
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