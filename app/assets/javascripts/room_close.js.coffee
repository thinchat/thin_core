$ ->
  $('.close_room').click ->
    closeRoom($(this).attr("id"))
    $('#myModal').modal('show')

  $('.log_send').click ->
    $('#myModal').modal('hide')

  closeRoom = (id) -> 
    $.ajax({
        type: 'PUT',
        url: "/api/v1/rooms/#{id}",
        data: {"room": { "status": "Closed"}},
        success: (response) ->
          console.log response
        })
