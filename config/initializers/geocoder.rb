REDIS = ENV['REDISCLOUD_URL'] ? Redis.new( url: ENV['REDISCLOUD_URL'] ) : Redis.new

Geocoder.configure(
  lookup: :mapbox,
  api_key: ENV['mapbox_api_key'],
  cache: REDIS
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

  Geocoder::Lookup::Test.add_stub('Yaba', [
    {
      'latitude'     => 6.73827991580656,
      'longitude'    => 11.7079757899046,
      'address'      => 'Yaba',
      'state'        => 'Lagos State',
      'state_code'   => 'LOS',
      'country'      => 'Nigeria',
      'country_code' => 'NG'
    }

  ])
  Geocoder::Lookup::Test.add_stub('Abuja', [
    {
      'latitude'     => 8.993,
      'longitude'    => 7.442,
      'address'      => 'Abuja',
      'state'        => 'FCT',
      'state_code'   => 'ABJ',
      'country'      => 'Nigeria',
      'country_code' => 'NG'
    }

  ])
  Geocoder::Lookup::Test.add_stub('Warri', [
    {
      'latitude'     => 53.402014,
      'longitude'    => -2.568332,
      'address'      => 'Warri',
      'state'        => 'Delta State',
      'country'      => 'Nigeria',
      'country_code' => 'NG'
    }

  ])
end
##END Test
