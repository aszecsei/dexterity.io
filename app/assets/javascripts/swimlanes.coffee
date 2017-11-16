# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class SwimlanesController
    index: ->
        $ ->
            $('[id^="swimlane_"]').sortable(
              connectWith: '.connectedSortable'
              revert: true).disableSelection()
            return
        $('.modal').modal()
        $('select').material_select()
        $( '#add' ).validate
            rules:
                name:
                    required: true
                description:
                    required: true
                status:
                    required: true
                category:
                    required: true

                assignee:
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
          url = "/api/issues"
          $.ajax
            type: 'POST'
            headers: {"Authorization": "Token token=" + $("#token").val()}
            url: url
            data: $("#add").serialize()
            success: (data) ->
              #$("#projects-row").append(generateProjectCard(data.name, data.description, '#', '#', '#'))
              $("#swimlane_" + data.status_id).append($("<li class = 'ui-state-default'>").append(generateIssueCard(data.name,data.description)))
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
this.app.swimlanes = new SwimlanesController