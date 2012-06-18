class @RoomsShowUserPresenter
  @renderUsers: (users) =>
    for user in users
      RoomsShowUserPresenter.addUser(user)

  @handleUser: (data, refreshList) =>
    console.log data
    console.log refreshList
    if (data.message_type == "Subscribe")
      refreshList()
    else if (data.message_type == "Disconnect")
      refreshList()