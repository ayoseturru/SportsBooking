json.array!(@installations) do |installation|
  json.extract! installation, :id, :name, :address
  json.url installation_url(installation, format: :json)
end
