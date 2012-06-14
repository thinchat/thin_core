class @GuestsIndexUserPresenter
  @renderUsers: (users) =>
    for user in users
      console.log user
      GuestsIndexUserPresenter.addUser(user)

  @handleUser: (data) =>
    if (data.message_type == "Subscribe")
      GuestsIndexUserPresenter.addUser(data)
    else if (data.message_type == "Disconnect")
      GuestsIndexUserPresenter.removeUser(data.metadata.client_id)

  @addUser: (user) =>
    $('#users').append Mustache.to_html($('#user_template').html(), user)

  @removeUser: (client_id) =>
    $(".#{client_id}").remove()