FactoryGirl.define do
  sequence :address_1 do |i|
    "address_1 #{i}"
  end

  sequence :address_2 do |i|
    "address_2 #{i}"
  end

  sequence :city do |i|
    "city #{i}"
  end

  sequence :state do |i|
    "state #{i}"
  end

  sequence :country do |i|
    "country #{i}"
  end

  sequence :postal_code
  # do |i|
  #
  # end

  factory :address do
    company
    address_1
    address_2
    city
    state
    country
    postal_code
  end
end
