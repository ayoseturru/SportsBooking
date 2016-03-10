json.array!(@time_bands) do |time_band|
  json.extract! time_band, :id, :date
  json.url time_band_url(time_band, format: :json)
end
