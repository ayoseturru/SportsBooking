require 'date'
require 'digest'

sports_center_installation = Installation.create(name: "Sports Center", address: "Campus Universitario de Tafira")
outdoor_football_installation = Installation.create(name: "Outdoor Court", address: "Campus Universitario de Tafira")
football_stadium = Installation.create(name: "ULPGC Football Stadium", address: "Campus Universitario de Tafira")
basketball_outdoor= Installation.create(name: "Basketball Outdoor Court", address: "Campus Universitario de Tafira")

indoor_football = Sport.create(name: "Futsal", max_players: 10, installations: [sports_center_installation, outdoor_football_installation])
football_seven_a_side = Sport.create(name: "Football Seven-a-side", max_players: 14, installations: [football_stadium])
football = Sport.create(name: "Football", max_players: 22, installations: [football_stadium])
basketball = Sport.create(name: "Basketball", max_players: 10, installations: [sports_center_installation, basketball_outdoor])


sports_installations = [
    SportsInstallation.create(sport_id: indoor_football.id, installation_id: outdoor_football_installation.id),
    SportsInstallation.create(sport_id: indoor_football.id, installation_id: sports_center_installation.id),
    SportsInstallation.create(sport_id: football_seven_a_side.id, installation_id: football_stadium.id),
    SportsInstallation.create(sport_id: football.id, installation_id: football_stadium.id),
    SportsInstallation.create(sport_id: basketball.id, installation_id: basketball_outdoor.id),
    SportsInstallation.create(sport_id: basketball.id, installation_id: sports_center_installation.id)
]


def mock_time_band(month, days, sports_installations)
  days.times do |day|
    8.times do |hour|
      TimeBand.create(start_hour: "#{8 + (hour % 2 == 0 ? (hour / 2) + hour : (hour / 3) + hour)}:#{hour % 2 == 0 ? '00' : '30'}", date: Date.new(2016, month, day + 1), end_hour: "#{9 + (hour % 2 == 0 ? (hour / 2) + hour : hour + ((hour + 1)/2))}:#{hour % 2== 0 ? '30' : '00'}", sports_installations: sports_installations)
    end
  end
end

mock_time_band(Time.now.month, Time.days_in_month(Time.now.month, Time.now.year), sports_installations) # March Timebands


test_user = User.create(dni: "test", password: Digest::SHA1.hexdigest("12345678"))
test1_user = User.create(dni: "test1", password: Digest::SHA1.hexdigest("12345678"))

teams = [Team.create(name: "football", user: test_user),
         Team.create(name: "basketball", user: test_user)]

test_user.update(teams: teams)

# Example of how to create a booking
Booking.create(sports_installation_id: sports_installations.first.id, time_band_id: TimeBand.first.id, user_id: test_user.id)
