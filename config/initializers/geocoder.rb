  Geocoder.configure(
    lookup: :mapbox,
    api_key: ENV['mapbox_api_key'],
    cache: Redis.new

  )

##Test
if Rails.env.test?
  Geocoder.configure(:lookup => :test)
  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        'latitude'     => 6.508,
        'longitude'    => 3.375,
        'address'      => 'Lagos',
        'state'        => 'Lagos State',
        'state_code'   => 'LOS',
        'country'      => 'Nigeria',
        'country_code' => 'NG'
      }
    ]
  )
end
##END Test
