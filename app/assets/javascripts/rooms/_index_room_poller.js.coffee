class @RoomsIndexRoomPoller
  constructor: (rooms_url) ->
    @rooms_url = rooms_url
    @refreshList()

  refreshList: =>
    rooms = $.getJSON(@rooms_url, @renderRooms)
    setTimeout((=> @refreshList()), 5000)

  renderRooms: (rooms) =>
    for room in rooms
      @addRoom(room)

  addRoom: (room) =>
    if $("#room-#{room.name}").length > 0
      $("#room-#{room.name}").replaceWith(Mustache.to_html($('#room_user_template').html(), room))
    else
      $('#rooms').append Mustache.to_html($('#room_template').html(), room)