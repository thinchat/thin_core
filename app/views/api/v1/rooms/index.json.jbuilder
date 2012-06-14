json.array!(@rooms) do |json, room|
  json.(room, :name, :id, :created_at, :status)
  json.location room_url(room)
end