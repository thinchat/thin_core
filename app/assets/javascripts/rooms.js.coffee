# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.namespace = {
  getUser: (room_id) =>
    user_hash = JSON.parse(user)
    user_hash.room_id = room_id if room_id?
    user_hash
}