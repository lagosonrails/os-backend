module RequestJsonHelper
  RSpec.configure do |config|
    config.include self, type: :request
  end

  def json
    JSON.parse(response.body, symbolize_names: true)
  end
end

# RSpec.configure do |config|
# config.include(EmailSpec::Helpers)
# config.include(EmailSpec::Matchers)
#
# # Include OmniAuth mock_auth configuration for Nike
# config.include(OmniauthMacros)
#
# # make rspec assume that a spec in spec/controllers is a controller spec
# # https://www.relishapp.com/rspec/rspec-rails/docs/upgrade#file-type-inference-disabled
# config.infer_spec_type_from_file_location!
# config.verbose_retry = true
#
# # Request Helpers for api specs
# config.include Requests::JsonHelpers, type: :request
