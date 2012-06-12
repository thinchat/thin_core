# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.namespace = {
  getUser: (location) =>
    user_hash = $('#user').data('user')
    user_hash.location = location if location?
    user_hash

  fayeLoader: =>
    location = $('#messages').data('location')
    ChatHandler.getMessages(location)
    user_hash = $.namespace.getUser(location)
    
    faye_chat = new FayeHandler(user_hash, '/messages/'+ location, ChatHandler.handleMessage)
    $("#new_message").live("ajax:complete", (event,xhr,status) ->
      $('#new_message')[0].reset())
}