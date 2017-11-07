# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class SwimlanesController
    index: ->
        $ ->
            $('[id^="swimlane_"]').sortable(connectWith: '.connectedSortable').disableSelection()
            return

this.app.swimlanes = new SwimlanesController