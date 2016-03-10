json.array!(@bookings) do |booking|
  json.extract! booking, :id, :sports_installation, :time_band
  json.url booking_url(booking, format: :json)
end
