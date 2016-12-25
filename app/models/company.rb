class Company < ApplicationRecord
  has_many :addresses

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
