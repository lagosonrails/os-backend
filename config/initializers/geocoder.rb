unless Rails.env.development?
  Geocoder.configure(
    # :lookup => :google,
    # :ip_lookup => :ip_address_labs,

    api_key: 'AIzaSyA-kf5I1_5NlRx3Iaf_z94yFWHBMox-pP0',
    cache: Redis.new
    # :api_key => "AIzaSyAEALUV3stEk3-WheIPKEiUOKeEMyf7aUY",
    # :use_https => true,
    #
    # :google => {
    #   :api_key => "AIzaSyA-kf5I1_5NlRx3Iaf_z94yFWHBMox-pP0"
    # },
    # :ip_address_labs => {
    #   :api_key => "SAKH6D8QX74D2Q27RKEZ"
    # },
  )
end

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
