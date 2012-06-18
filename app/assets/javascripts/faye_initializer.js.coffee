class @FayeInitializer
  constructor: (faye_url) ->
    @client = new Faye.Client(faye_url + '/faye')
    @client.disable('callback-polling')
    @client.disable('long-polling')
    @client.disable('cross-origin-long-polling')
    return @client