# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class SwimlanesController
    index: ->
        $('[id^="swimlane_"]').sortable(
            items: "> :not(.ui-state-disabled)"
            update: (e, ui) ->
                if this == ui.item.parent()[0]
                    ui.item[0].classList.add("ui-state-disabled")
                    indexAt = 0
                    id = ui.item[0].firstElementChild.id
                    parent = ui.item.context.parentNode.id.split('_')[1]
                    next = -1
                    console.log 
                    while ui.item.context.parentNode.children[indexAt].firstElementChild.id != id
                        indexAt++
                    if indexAt != 0
                        next = ui.item.context.parentNode.children[indexAt - 1].firstElementChild.id
                    data = {status_id:parent, issue_id:id,prev_id:next}
                    console.log data
                    url = "/api/issues/reorder"
                    $.ajax
                        type: 'POST'
                        headers: {"Authorization": "Token token=" + $("#token").val()}
                        url: url
                        data: data
                        success: (data) ->
                            #$("#projects-row").append(generateProjectCard(data.name, data.description, '#', '#', '#'))
                            ui.item[0].classList.remove("ui-state-disabled")
                            return
                        error: (req, msg, stat) ->
                            alert("AJAX Issue");
                            location.reload();
                            return
                return
            connectWith: '.connectedSortable'
            revert: true).disableSelection()
        
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
          url = "/api/issues"
          console.log $("#add").serialize()
          $.ajax
            type: 'POST'
            headers: {"Authorization": "Token token=" + $("#token").val()}
            url: url
            data: $("#add").serialize()
            success: (data) ->
              #$("#projects-row").append(generateProjectCard(data.name, data.description, '#', '#', '#'))
              $("#swimlane_" + data.status_id).append($("<li class = 'ui-state-default'>").append(generateIssueCard(data.name,data.description,data.category,data.story_points,data.id)))
              $("#swimlaneModal").modal('close');
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
        
        $(".openbtn").click (e) ->
            active = $(this).attr("data")
            e.preventDefault()
            $.ajax
                type: 'GET'
                headers: {"Authorization": "Token token=" + $("#token").val()}
                url: "/api/issues/#{active}/activity"
                success: (data) ->
                    $("#issueName").text(data.name)
                    $("#issueDesc").text(data.description)
                    actList = ""
                    for l, i in data.log
                        do (l, i)->
                            actList += "<div class='activityItem'>#{l.user_disp} #{l.desc}<br/>#{l.type}</div>"
                    $("#activityList").html(actList)
                    $("#issueModel").modal('open')
                    return
                error: (req, msg, stat) ->
                    response = JSON.parse(req.responseText)
                    errorsArr = (msg.detail for msg in response.errors)
                    errorsHTML = errorsArr.join("\n")
                    alert(errorsHTML)
                    return
            return
        return
this.app.swimlanes = new SwimlanesController