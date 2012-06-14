json.array!(@users) do |json, user|
  json.(user, :user_name, :user_type, :user_id, :channel)
  json.metadata do |json|
    json.location user.location
    json.client_id user.client_id
  end
end