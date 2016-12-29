json.extract! address, :id, :address_1, :address_2, :city, :state, :country, :longitude, :latitude, :postal_code, :active, :formatted_address
json.company do
  json.partial! "#{view_namespace_path}/companies/company", company: address.company if address.company
end
