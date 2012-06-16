class @ChatInitializer
  @initialize: (api_url) =>
    $(".new_message").live("ajax:complete", (event,xhr,status) ->
      $('html, body').animate({scrollTop:$(document).height()}, 'slow');
      $(this)[0].reset())

    $("a.fancybox").fancybox()
    
    $("#message_body").keypress (e) ->
      if (e.which == 13 && e.shiftKey == false)
        $("#new_message").submit()

  @showModalHandler: =>
    $(document).on 'click','.close_room', (e) ->
      ChatHandler.closeRoom($(this).data("room_name"))
      $('#logModal').modal('show')

  @closeRoom = (room_name) ->
    $.ajax({
        type: 'PUT',
        url: "/api/v1/rooms/#{room_name}",
        data: {"room": { "status": "Closed"}},
        success: (response) ->
        })