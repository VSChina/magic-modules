require 'api/object'

module Provider
  module Azure
    module Terraform
      class Example < Api::Object
        module Helpers
          def get_example_properties_to_check(product_name, example_name, object)
            request = object.azure_sdk_definition.read.request
            param_props = object.all_user_properties.select{|p| request.has_key?(p.azure_sdk_references[0])}
            params = param_props.map{|p| p.name.underscore}.to_set

            example = get_example_from_file(product_name, example_name)
            example.properties.reject{|pn, pv| params.include?(pn)}
          end
        end
      end
    end
  end
end
