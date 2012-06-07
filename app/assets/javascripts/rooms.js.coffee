# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $.faye = new Faye.Client(faye_url + '/faye')
  runHeartbeat(jQuery.faye, getUserhash())

runHeartbeat = (client, user) ->
  client.publish('/heart_beat', user)
  setTimeout((-> runHeartbeat(client, user)), 10000)

getUserhash = ->
  user_hash = JSON.parse(user)
  user_hash.room = room if typeof room isnt "undefined"
  user_hash