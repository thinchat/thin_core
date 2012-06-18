class @RoomsIndexRoomPoller
  constructor: (rooms_url) ->
    @rooms_url = rooms_url
    @refreshList()

  refreshList: =>
    console.log("Mr. Anderson, I'm polling...")
    rooms = $.getJSON(@rooms_url, @renderRooms)
    setTimeout((=> @refreshList()), 5000)

  renderRooms: (rooms) =>
    room_html_string = "<ul class='active'>"
    for room in rooms
      room_html_string += @addRoom(room)
    room_html_string += '</ul>'
    $('.active').quicksand( $(room_html_string).find('li') );


  addRoom: (room) =>
    Mustache.to_html($('#room_user_template').html(), room)