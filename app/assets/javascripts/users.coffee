# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class UsersController
  new: ->
    $( '#formValidate' ).validate
      rules:
        username:
          required: true
          minlength: 5
        email:
          required: true
          email: true
        password:
          required: true
          minlength: 5
        confirmpassword:
          required: true
          minlength: 5
          equalTo: '#password'
      messages:
        username:
          minlength: "Enter at least 5 characters"
        email:
          email: "Enter a valid email"
        confirmpassword:
          equalTo: 'Passwords must match'                                                             
      errorElement: 'div'
      errorPlacement: (error, element) ->
        placement = $(element).data('error')
        if placement
          $(placement).append error
        else
          error.insertAfter element
        return
    $('#formValidate').submit (e) ->
      url = '/api/register'
      $.ajax
        type: 'POST'
        url: url
        data: $('#formValidate').serialize()
          success: (data) ->
            $("#see_comments").click ->
              $('<form action="/login" method="POST">' + 
                '<input type="hidden" name="token" value="' + data.token + '">' +
                '</form>').submit();
            return
          failure: (data) ->
            $("#errorMsg").text(data.message)
      e.preventDefault()
      return
    return

this.app.users = new UsersController