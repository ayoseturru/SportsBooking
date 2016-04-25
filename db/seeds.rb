require 'date'
require 'digest'

sports_center_installation = Installation.create(name: "Sports Center", address: "Campus Universitario de Tafira", images: "sports_centers_1,sports_centers_2,sports_centers_3", map_url: "https://www.google.com/maps/embed?pb=!1m0!3m2!1ses!2ses!4v1461055363647!6m8!1m7!1s4P-ozm_lVhCUOq-7TqJN4g!2m2!1d28.06860433735539!2d-15.45551653099488!3f285.2632814355912!4f-8.543636159967107!5f0.7820865974627469")
outdoor_football_installation = Installation.create(name: "Outdoor Court", address: "Campus Universitario de Tafira", images: "outdoor_court_1,outdoor_court_2", map_url: "https://www.google.com/maps/embed?pb=!1m0!3m2!1ses!2ses!4v1461054193992!6m8!1m7!1s0RvE4C30Ln0Zl7S9WFfEcw!2m2!1d28.07096325667804!2d-15.45631463438623!3f309.88741509755863!4f-10.359925153472062!5f0.7820865974627469")
football_stadium = Installation.create(name: "ULPGC Football Stadium", address: "Campus Universitario de Tafira", images: "football_stadium_1,football_stadium_2,football_stadium_3", map_url: "https://www.google.com/maps/embed?pb=!1m0!3m2!1ses!2ses!4v1461054193992!6m8!1m7!1s0RvE4C30Ln0Zl7S9WFfEcw!2m2!1d28.07096325667804!2d-15.45631463438623!3f309.88741509755863!4f-10.359925153472062!5f0.7820865974627469")
basketball_outdoor= Installation.create(name: "Basketball Outdoor Court", address: "Campus Universitario de Tafira", images: "basketball_outdoor_1,basketball_outdoor_2,basketball_outdoor_3", map_url: "https://www.google.com/maps/embed?pb=!1m0!3m2!1ses!2ses!4v1461055363647!6m8!1m7!1s4P-ozm_lVhCUOq-7TqJN4g!2m2!1d28.06860433735539!2d-15.45551653099488!3f285.2632814355912!4f-8.543636159967107!5f0.7820865974627469")

indoor_football = Sport.create(name: "Futsal", max_players: 10, installations: [sports_center_installation, outdoor_football_installation])
football_seven_a_side = Sport.create(name: "Football Seven-a-side", max_players: 14, installations: [football_stadium])
football = Sport.create(name: "Football", max_players: 22, installations: [football_stadium], )
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


test_user = User.create(dni: "test", name: "Elric", password: Digest::SHA1.hexdigest("12345678"))
test1_user = User.create(dni: "test1", name: "Alfonso", password: Digest::SHA1.hexdigest("12345678"))
test2_user = User.create(dni: "test2", name: "Dante", password: Digest::SHA1.hexdigest("12345678"))
test3_user = User.create(dni: "test3", name: "Asmodeus", password: Digest::SHA1.hexdigest("12345678"))

teams = [Team.create(name: "football", sport_id: 1, user_id: test_user.id),
         Team.create(name: "basketball", sport_id: 2, user_id: test_user.id)]

test_user.update(teams: teams)

# Example of how to create a booking
Booking.create(sports_installation_id: sports_installations.first.id, time_band_id: TimeBand.first.id, user_id: test_user.id, participants: "test,test1", max_size: 20)
