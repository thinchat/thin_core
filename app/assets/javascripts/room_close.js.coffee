$ ->
  $('.close_room').click ->
    closeRoom($(this).attr("id"))
    $('#myModal').modal('show')

  $('.log_send').click ->
    $('#myModal').modal('hide')

  closeRoom = (id) -> 
    alert id