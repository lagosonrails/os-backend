module GooglePlaces::Errors
  class MissingRequiredKeyError < StandardError
    require 'erb'
    attr_reader :object

    def initialize(message=nil, object=nil)
      @object = object
    end

    def message
      ERB.new(<<~EOF).result(binding)
        Please provide the required keys. This route requires the following key(s):
        <% if object %>
          <% object.required_params_for_search.each do |key| %>
            * <%= key %>
          <% end %>
        <% end %>
      EOF
    end
  end
end
