# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ () ->
  $when = $('input#when')
  $when_repr = $('#when_repr')
  $occurs_at = $('#occurs_at')
  $when.keypress () ->
      d = Date.parse($when.val())
      if d
        s = d.toString('dddd, MMMM d, yyyy')
        $when_repr.html(s)
        s2 = d.toISOString()
        $occurs_at.val(s2)
