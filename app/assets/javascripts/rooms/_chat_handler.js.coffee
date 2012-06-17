class @ChatHandler
  @getMessages: (url, callback) ->
    $.getJSON(url, callback)

  @renderMessages: (messages) =>
    for message in messages
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

  @showModalHandler:(api_v1_messages_url, user_hash) =>
    $('.close_room').click ->
      name = $(this).data("room-name")
      $.ajax({
          type: 'POST',
          url: "#{api_v1_messages_url}",
          data: {"message": $.extend({"message_type":"CloseRequest", "body":"An agent has requested that this room be closed."}, user_hash)},
          success: (response) ->
          })
  
  @closeRoom = (id) ->
    $.ajax({
        type: 'PUT',
        url: "/api/v1/rooms/#{id}",
        data: {"room": { "status": "Closed"}},
        success: (response) ->
        })
