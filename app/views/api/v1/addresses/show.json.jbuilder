json.address do
  json.partial! "#{view_namespace_path}/addresses/address", address: @address
end
