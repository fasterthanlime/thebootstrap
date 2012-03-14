# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ () ->
  $when = $('input#when')
  $when_repr = $('#when_repr')
  $occurs_at = $('#occurs_at')
  update_when = () ->
      d = Date.parse($when.val())
      if d
        s = d.toString('dddd, MMMM d, yyyy, HH:mm')
        $when_repr.html(s)
        s2 = d.toISOString()
        $occurs_at.val(s2)
        $when.addClass 'valid' 
      else
        $when.removeClass 'valid' 
  $when.keypress update_when
  $when.change update_when

  update_name = () ->
      v = $(this).val()
      if v.length > 0
        $(this).addClass 'valid'
      else
        $(this).removeClass 'valid'
  $('input#name, input#place').keypress(update_name).change(update_name)

