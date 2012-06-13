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
    user_hash = $.namespace.getUser(location)
    
    faye_chat = new FayeHandler(user_hash, '/messages/'+ location, ChatHandler.handleMessage)
    $("#new_message").live("ajax:complete", (event,xhr,status) ->
      $('#new_message')[0].reset())
}

clientSideValidations.callbacks.element.fail = (element, message, callback) ->
  callback()
  if element.data("valid") isnt false
    element.parent().parent().parent().parent().find('input[type="submit"]').attr('disabled','disabled')

clientSideValidations.callbacks.element.pass = (element, callback, eventData) ->
  callback()
  element.parent().parent().parent().parent().find('input[type="submit"]').removeAttr('disabled')