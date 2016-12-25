class Address < ApplicationRecord
  belongs_to :company

  # geocode if there is an address and no longitude and latitude
  geocoded_by :full_address
  after_validation :geocode, if: :should_geocode?

  # reverse_geocode if there is lat/long but no address(autolocator)
  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.address_1 = geo.address
      obj.city = geo.city
      obj.state = geo.state
      obj.postal_code = geo.postal_code
      obj.country = geo.country
    end
  end
  after_validation :reverse_geocode, if: :should_reverse_geocode?

  def should_geocode?
    latitude.blank? || longitude.blank? || address_changed?
  end

  def address_changed?
    unless new_record?
      address_1_changed?        ||
      address_2_changed?        ||
      city_changed?             ||
      state_changed?            ||
      postal_code_changed?      ||
      country_changed?
    end
  end

  def should_reverse_geocode?
    full_address.blank? || coordinates_changed?
  end

  def coordinates_changed?
    unless new_record?
      latitude_changed? ||
      longitude_changed?
    end
  end

  def full_address
    [
      address_1,
      address_2,
      city,
      state,
      postal_code,
      country
    ].compact.join(', ')
  end
end


  # do |obj, result|
  #   binding.pry
  # end

  # , if: proc{ |obj, result|
  #   require 'pry' ; binding.pry
  #   obj.full_address.blank?
  # }
