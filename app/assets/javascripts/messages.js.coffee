# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  ChangeLinks()

ChangeLinks = ->
  messages = $(".message")
  for message in messages
    html = $(message).html()
    $(message).html(replaceLinks(html))
    

replaceLinks = (original) ->
  matchedHttp = original.match /(https?:\/\/.*\.(?:png|jpg|jpeg))/i
  if matchedHttp
    original = original.replace matchedHttp[0], ""
    original = linkify(original)
    original = original + "<img src='#{matchedHttp[0]}' height=200 width=200></img>"
  else
    linkify(original)
  
  

