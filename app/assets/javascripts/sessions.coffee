# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class SessionsController
  new: ->
    $( '#formLogin' ).validate
      rules:
        username:
          required: true
        password:
          required: true

    $("#formLogin").submit (e) ->
      console.log("Boo!")
      url = "/api/login"
      $.ajax
        type: 'POST'
        url: url
        data: $("#formLogin").serialize()
        success: (data) ->
          $("#token").val(data.token)
          $("#formSession").submit();
          return
        error: (req, msg, stat) ->
          response = JSON.parse(req.responseText)
          errorsArr = (msg.detail for msg in response.errors)
          errorsHTML = errorsArr.join("\n")
          alert(errorsHTML)
          # $("#errorMsg").html(errorsHTML)
          return
      e.preventDefault()
      return
    return
    
this.app.sessions = new SessionsController