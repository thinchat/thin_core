class @RoomsIndexUserPresenter
  @renderUsers: (users) =>
    for user in users
      console.log user
      RoomsIndexUserPresenter.addUser(user)

  @handleUser: (data) =>
    if (data.message_type == "Subscribe")
      RoomsIndexUserPresenter.addUser(data)
    else if (data.message_type == "Disconnect")
      RoomsIndexUserPresenter.removeUser(data.metadata.client_id)

  @addUser: (user) =>
    $("#room-#{user.metadata.location}").find("#buddy_list").append Mustache.to_html($('#user_template').html(), user)

  @removeUser: (client_id) =>
    $(".#{client_id}").remove()

  @getUsers: (url, callback) ->
    $.getJSON(url, callback)