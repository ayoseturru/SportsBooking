json.array!(@sports_installations) do |sports_installation|
  json.extract! sports_installation, :id, :installation_id, :sport_id
  json.url sports_installation_url(sports_installation, format: :json)
end
