class @ChatInitializer
  @initialize: (api_url) =>
    $(".new_message").live("ajax:complete", (event,xhr,status) ->
      $('html, body').animate({scrollTop:$(document).height()}, 'slow');
      $(this)[0].reset())

    $("a.fancybox").fancybox()
    
    $("#message_body").keypress (e) ->
      if (e.which == 13 && e.shiftKey == false)
        e.preventDefault()
        $("#new_message").submit()

  @showModalHandler: (api_v1_messages_url, user_hash) =>
    $('.close_room').click ->
      name = $(this).data("room-name")
      $.ajax({
          type: 'POST',
          url: "#{api_v1_messages_url}",
          data: {"message": $.extend({"message_type":"CloseRequest", "body":"An agent has requested that this room be closed."}, user_hash)},
          success: (response) ->
          })
      ChatInitializer.closeRoom($(this).data("roomName"))

  @closeRoom = (room_name) ->
    $.ajax({
        type: 'PUT',
        url: "/api/v1/rooms/#{room_name}",
        data: {"room": { "status": "Closed"}},
        success: (response) ->
        })