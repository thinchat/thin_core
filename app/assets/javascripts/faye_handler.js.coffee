class @FayeHandler
  constructor: (faye_url, user_hash, channel) ->
    @client = new Faye.Client(faye_url + '/faye')
    @user_hash = user_hash
    @channel = channel

  joinRoomAndPulse: (callback) =>
    @subscribe(callback)
    @addSubscribeExtension()
    @addPulse()

  joinRoom: (callback) =>
    @subscribe(callback)
    @addSubscribeExtension()

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

  addPulse: =>
    @client.publish('/heart_beat', @user_hash)
    setTimeout((=> @addPulse()), 10000)
