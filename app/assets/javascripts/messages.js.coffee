# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  changeLinks()

changeLinks = ->
  messages = $(".message")
  for message in messages
    html = $(message).html()
    $(message).html(replaceLinks(html))
    
replaceLinks = (content) ->
  images = content.match /(https?:\/\/(?:[a-z\-\d]+\.)+\S+\.(?:jpg|gif|png))/i
  if images
    replaceImages(images, content)
  else
    linkify(content)
  
replaceImages = (images, content) ->
  for image in images
    content = content.replace image, ""
  content = linkify(content)
  for image in images
    content = content + "<img src='#{image}' height=200 width=200></img>"
  content

