json.array!(@users) do |json, user|
  json.(user, :user_name, :user_type, :user_id, :channel)
  json.metadata do |json|
    json.location user.location
    json.client_id user.client_id
  end
  if user.client_ids.present?
    json.client_ids user.client_ids.to_json
  end
end