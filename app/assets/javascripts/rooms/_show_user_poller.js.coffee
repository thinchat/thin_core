class @RoomsShowUsersPoller
  constructor: (users_url) ->
    @users_url = users_url
    @refreshList()

  refreshList: =>
    rooms = $.getJSON(@rooms_url, @renderRooms)
    setTimeout((=> @refreshList()), 5000)

  renderUsers: (rooms) =>
    for user in users
      @addUser(room)

  addUser: (room) =>
    if $("#room-#{room.name}").length > 0
      $("#room-#{room.name}").replaceWith(Mustache.to_html($('#room_user_template').html(), room))
    else
      $('#rooms').append Mustache.to_html($('#room_user_template').html(), room)