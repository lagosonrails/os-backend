  Geocoder.configure(
    lookup: :mapbox,
    api_key: 'pk.eyJ1IjoibGFnb3NvbnJhaWxzIiwiYSI6ImNpeDNwaWVsczAwMHEyeW8zZTRqcDQ2azAifQ.0yJB8rh0xQflm9_rIzPG0Q',
    cache: Redis.new

  )

##Test
if Rails.env.test?
  Geocoder.configure(:lookup => :test)
  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        'latitude'     => 40.7143528,
        'longitude'    => -74.0059731,
        'address'      => 'New York, NY, USA',
        'state'        => 'New York',
        'state_code'   => 'NY',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ]
  )
end
##END Test
