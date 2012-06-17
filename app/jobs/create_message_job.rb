class CreateMessageJob
  @queue = :messages

  def self.perform(msg)
    params_hash = JSON.parse(msg)
    Message.create(params_hash)
  end
end