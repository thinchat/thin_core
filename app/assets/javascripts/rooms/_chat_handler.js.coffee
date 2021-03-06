class @ChatHandler
  @getMessages: (url, callback) ->
    $.getJSON(url, callback)

  @renderMessages: (messages) =>
    for message in messages
      ChatHandler.handleMessage(message)

  @handleFayeMessage: (user_hash, message) =>
    if ("#{message.user_id}" != user_hash.user_id)
      $('html, body').animate({scrollTop:window.pageYOffset + 20}, 'fast');
    ChatHandler.handleMessage(message)

  @handleMessage: (message) =>
    if (message.message_type == "Message")
      ChatHandler.addMessage(message)
    else if (message.message_type == "Document")
      ChatHandler.addDocument(message)
    else
      ChatHandler.addEvent(message)

  @addMessage: (message) =>
    mustache_message = Mustache.to_html($('#message_template').html(), message)
    $('#messages').append ChatHandler.linkMessage(mustache_message)

  @addEvent: (message) =>
    $('#messages').append Mustache.to_html($('#event_template').html(), message)

  @addDocument: (message) =>
    $('#messages').append Mustache.to_html($('#document_template').html(), message)

  @linkMessage: (content) ->
    images = content.match /http[s]?:\/\/(?:[a-z\-\d]+\.)+\S+\.(?:jpg|gif|png|jpeg)(?:\?.*)?/ig
    if images
      ChatHandler.replaceImages(images, content)
    else
      linkify(content)
    
  @replaceImages: (images, content) ->
    for image in images
      content = content.replace image, ""
    content = $(linkify(content))
    for image in images
      console.log content
      content.find('.chat_date').after "<div class='chat_image'><a href='#{image}' class='fancybox' target='_blank'><img src='#{image}'></img></a></div>"
    content

