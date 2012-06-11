json.array!(@messages) do |json, message|
  json.(message, :user_name, :user_type, :user_id, :room_id, :created_at)
  json.message_body message.body
  json.message_id message.id
  json.message_type "Message"
end