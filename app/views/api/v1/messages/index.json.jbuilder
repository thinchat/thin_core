json.array!(@messages) do |json, message|
  json.(message, :user_name, :user_type, :user_id, :room_id, :created_at, :message_type)
  json.message_body message.body
  json.message_id message.id
  json.metadata message.metadata
end