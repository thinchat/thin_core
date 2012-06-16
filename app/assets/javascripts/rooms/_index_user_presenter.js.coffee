class @RoomsIndexUserPresenter
  @renderUsers: (users) =>
    for user in users
      RoomsIndexUserPresenter.addUser(user)

  @handleUser: (data) =>
    console.log data
    if (data.message_type == "Subscribe")
      RoomsIndexUserPresenter.addUser(data)
    else if (data.message_type == "Disconnect")
      RoomsIndexUserPresenter.removeUser(data.metadata.client_id)

  @addUser: (user) =>
    $("#room-#{user.metadata.location}").append Mustache.to_html($('#user_template').html(), user)

  @removeUser: (client_id) =>
    $(".#{client_id}").remove()
