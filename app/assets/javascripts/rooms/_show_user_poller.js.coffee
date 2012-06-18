class @RoomsShowUsersPoller
  constructor: (users_url) ->
    @users_url = users_url
    @refreshList()

  refreshList: =>
    $.getJSON(@users_url, @renderUsers)
    setTimeout((=> @refreshList()), 10000)

  renderUsers: (users) =>
    @cleanUsers(users)
    for user in users
      @addUser(user)

  addUser: (user) =>
    if $(".user-#{user.user_id}").length > 0
      $(".user-#{user.user_id}").replaceWith( Mustache.to_html($('#user_with_client_ids_template').html(), user) )
    else
      $('#online_agents').append Mustache.to_html($('#user_with_client_ids_template').html(), user)

  cleanUsers: (online_users) =>
    users_in_list = $("#online_agents").find(".user")
    for user in users_in_list
      user_id = $(user).data('userId')
      @result = null

      for online_user in online_users
        if online_user.user_id == user_id
          @result = online_user

      $(user).remove() unless @result != null
