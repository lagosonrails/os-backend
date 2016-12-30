# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
# Indexes
#
#  index_companies_on_slug  (slug) UNIQUE
#

class Company < ApplicationRecord
  has_many :addresses

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
