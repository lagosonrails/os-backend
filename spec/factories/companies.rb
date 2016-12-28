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

FactoryGirl.define do
  sequence(:name) do |i|
    "company #{i}"
  end
  
  factory :company do
    name
  end
end
