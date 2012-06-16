json.array!(@rooms) do |json, room|
  json.(room, :name, :id, :created_at, :status)
  json.room_url room_url(room.name)
end