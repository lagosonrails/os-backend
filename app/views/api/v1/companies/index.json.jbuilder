json.companies(@companies) do |company|
  json.partial! "#{view_namespace_path}/companies/company", company: company
end
