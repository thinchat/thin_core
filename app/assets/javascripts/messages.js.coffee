# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  ChangeLinks()

ChangeLinks = ->
  messages = $(".message")
  for message in messages
    html = $(message).html()
    $(message).html(replaceLinks(html))
    

replaceLinks = (original) ->
  original = linkify(original)

