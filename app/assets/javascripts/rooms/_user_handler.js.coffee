class @UserHandler
  @getUsers: (url, callback) ->
    $.getJSON(url, callback)