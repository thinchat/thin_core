class @RoomsShowUserPresenter
  @renderUsers: (users) =>
    for user in users
      RoomsShowUserPresenter.addUser(user)

  @handleUser: (data) =>
    if (data.message_type == "Subscribe")
      RoomsShowUserPresenter.addUser(data)
    else if (data.message_type == "Disconnect")
      RoomsShowUserPresenter.removeUser(data)

  @addUser: (user) =>
    userDiv = $('#online_agents').find(".user-#{user.user_id}")
    if userDiv.length == 0
      $('#online_agents').append Mustache.to_html($('#user_template').html(), user)
      userDiv = $('#online_agents').find(".user-#{user.user_id}")
      userDiv.data('client-ids', ["#{user.metadata.client_id}"])
    else
      client_ids = userDiv.data('client-ids')
      client_ids.push("#{user.metadata.client_id}")
      userDiv.data('client-ids', client_ids)

  @removeUser: (user) =>
    console.log user
    userDiv = $('#online_agents').find(".user-#{user.user_id}")
    if userDiv.length > 0
      client_ids = userDiv.data('client-ids')
      client_ids = RoomsShowUserPresenter.removeClientId(client_ids, "#{user.metadata.client_id}")
      if client_ids.length == 0
        userDiv.remove()
      else
        userDiv.data('client-ids', client_ids)

  @removeClientId: (client_ids, remove_id) ->
    jQuery.grep(client_ids, (client_id) ->
      client_id isnt remove_id
    )