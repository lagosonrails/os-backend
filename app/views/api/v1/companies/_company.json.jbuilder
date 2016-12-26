# json.company do
#    json.id company.id
#    json.name company.name
#    json.slug company.slug
#  end
# require 'pry' ; binding.pry
  json.extract! company, :id, :name, :slug
