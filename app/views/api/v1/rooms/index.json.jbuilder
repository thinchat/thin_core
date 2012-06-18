json.array!(@rooms) do |json, room|
  json.(room, :name, :id, :created_at, :status)
  json.room_url room_url(room.name)
  json.pretty_time room.pretty_time
  json.users room.users do |json, user|
    json.(user, :user_name, :user_type, :user_id, :channel)
    json.metadata do |json|
      json.location user.location
      json.client_id user.client_id
    end
  end
end