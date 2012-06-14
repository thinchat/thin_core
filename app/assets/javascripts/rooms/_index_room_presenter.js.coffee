class @RoomsIndexRoomPresenter
  @renderRooms: (rooms) =>
    for room in rooms
      RoomsIndexRoomPresenter.addRoom(room)

  @handleRoom: (data) =>
    if (data.chat_message.message_type == "Subscribe")
      RoomsIndexRoomPresenter.addUser(data.chat_message)
    else if (data.chat_message.message_type == "Disconnect")
      RoomsIndexRoomPresenter.removeUser(data.chat_message.client_id)

  @addRoom: (room) =>
    $('#rooms').append Mustache.to_html($('#room_template').html(), room)

  @removeRoom: (room_id) =>
    $('#rooms').find(".#{room_id}").remove()