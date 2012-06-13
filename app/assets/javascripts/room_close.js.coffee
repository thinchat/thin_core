$ ->
  $('#open_modal').click ->
    alert "hi"
    $('#myModal').modal('show')

  $('.log_send').click ->
    $('#myModal').modal('hide')