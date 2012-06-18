class @FayeHandler
  constructor: (faye_url, user_hash, channel) ->
    @client = new Faye.Client(faye_url + '/faye')
    @client.disable('callback-polling')
    @client.disable('long-polling')
    @client.disable('cross-origin-long-polling')
    @user_hash = user_hash
    @channel = channel

  joinRoomAndPulse: (callback) =>
    @subscribe(callback)
    @addSubscribeExtension()
    @addCloseExtension() if @user_hash.user_type == "Guest"
    @addPulse()

  joinRoom: (callback) =>
    @subscribe(callback)
    @addSubscribeExtension()
    @addCloseExtension() if @user_hash.user_type == "Guest"

  subscribe: (callback) =>
    @client.subscribe(@channel, (data) =>
      callback(data.chat_message)
    )

  publish: (data) =>
    @client.publish(@channel, data)

  addSubscribeExtension: =>
    @client.addExtension outgoing: (message, callback) =>
      if message.channel is "/meta/subscribe"
        message.data = message.data or @user_hash
      callback message

  addCloseExtension: =>
    @client.addExtension incoming: (message, callback) =>
      if message.channel is "#{@channel}"
        $('#logModal').modal('show') if message.data.chat_message.message_type == "CloseRequest"
      callback message

  addPulse: =>
    @client.publish('/heart_beat', @user_hash)
    setTimeout((=> @addPulse()), 2500)
