json.array!(@teams) do |team|
  json.extract! team, :id, :user_id, :name, :sport
  json.url team_url(team, format: :json)
end
