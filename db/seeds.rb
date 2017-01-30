# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

raise GooglePlaces::Errors::InvalidKeyError if ENV['google_places_api_key'].blank?


# initialize with
search = GooglePlacesService.text_search(query: 'yaba', radius: 50000, type: 'bank')
total = 0

while search.success? && search.results.present?
  places = search.results.places

  Company.transaction do
    # we would need a way to map/remap companies to addresses, as the Google Places API doesn't define relationships
    # therefore, there is a possibility of having Sterling Bank Ikoyi, Sterling Bank Ogba, Sterling Bank PLC Ikeja
    # as different places, we could do fuzzy matching but it may not be effective enough, also we could do admin
    # relationships mapping, since it's open source, we may also allow the community members chime in here
    places.each do |place|
      company = Company.find_or_initialize_by(name: place.name)
      company.addresses.new(
        latitude: place.latitude,
        longitude: place.longitude
      )
      company.save
    end
    total += places.size
  end
  search = search.next_page
end

puts "Yippe!! Successfully seeded #{total} addresses!!!"
