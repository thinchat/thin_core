class @AgentsIndexUserPresenter
  @renderUsers: (users) =>
    for user in users
      console.log user
      AgentsIndexUserPresenter.addUser(user)

  @handleUser: (data) =>
    if (data.message_type == "Subscribe")
      AgentsIndexUserPresenter.addUser(data)
    else if (data.message_type == "Disconnect")
      AgentsIndexUserPresenter.removeUser(data)

  @addUser: (user) =>
    userDiv = $('#users').find(".user-#{user.user_id}")
    if userDiv.size() == 0
      $('#users').append Mustache.to_html($('#user_template').html(), user)
      userDiv = $('#users').find(".user-#{user.user_id}")
      userDiv.data('client-ids', ["#{user.metadata.client_id}"])
    else
      client_ids = userDiv.data('client-ids')
      client_ids.push("#{user.metadata.client_id}")
      userDiv.data('client-ids', client_ids)

  @removeUser: (user) =>
    userDiv = $('#users').find(".user-#{user.user_id}")
    if userDiv.size() > 0
      client_ids = userDiv.data('client-ids')
      client_ids = AgentsIndexUserPresenter.removeClientId(client_ids, "#{user.metadata.client_id}")
      if client_ids.size == 0
        userDiv.remove()
      else
        userDiv.data('client-ids', client_ids)

  @removeClientId: (client_ids, remove_id) ->
    jQuery.grep(client_ids, (client_id) ->
      client_id isnt remove_id
    )