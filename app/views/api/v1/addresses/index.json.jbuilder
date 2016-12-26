json.addresses(@addresses) do |address|
  json.partial! "#{view_namespace_path}/addresses/address", address: address
end
