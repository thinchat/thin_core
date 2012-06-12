# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.namespace = {
  getUser: (location) =>
    user_hash = $('#user').data('user')
    user_hash.location = location if location?
    user_hash
}