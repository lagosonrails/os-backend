# == Schema Information
#
# Table name: addresses
#
#  id             :integer          not null, primary key
#  company_id     :integer
#  address_1      :string
#  address_2      :string
#  city           :string
#  state          :string
#  country        :string
#  postal_code    :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  latitude       :float
#  longitude      :float
#  archive_number :string
#  archived_at    :datetime
#
# Indexes
#
#  index_addresses_on_company_id  (company_id)
#

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

  factory :address do
    company

    factory :address_with_full_address do
      address_1
      address_2
      city
      state
      country
      postal_code
    end

    factory :address_with_coordinates do
      latitude 6.49789205180561
      longitude 3.38292296044528
    end
  end
end
