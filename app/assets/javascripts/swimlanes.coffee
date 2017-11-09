# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class SwimlanesController
    index: ->
        $ ->
            $('[id^="swimlane_"]').sortable(connectWith: '.connectedSortable').disableSelection()
            return
        $('.modal').modal()
        $('select').material_select()
        $( '#add' ).validate
            rules:
                name:
                    required: true
                    minlength: 5
                description:
                    required: true
                status:
                    required: true
                category:
                    required: true
                swimlane:
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
this.app.swimlanes = new SwimlanesController