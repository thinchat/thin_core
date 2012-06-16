class @RoomHandler
  @getRooms: (api_v1_rooms_url, callback) ->
    $.getJSON(api_v1_rooms_url, callback)