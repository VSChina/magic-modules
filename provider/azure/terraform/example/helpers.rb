require 'api/object'

module Provider
  module Azure
    module Terraform
      class Example < Api::Object
        module Helpers
          def get_example_properties_to_check(example_name, object)
            request = object.azure_sdk_definition.read.request
            param_props = object.all_user_properties.select{|p| p.azure_sdk_references.any?{|ref| request.has_key?(ref)}}
            params = param_props.map{|p| p.name.underscore}.to_set

            example = get_example_by_names(example_name)
            example.properties
              .reject do |pn, pv|
                params.include?(pn) || pn == 'location'
              end
              .transform_values do |v|
                v.is_a?(String) && !v.match(/\$\{.+\}/).nil? ? :AttrSet : v
              end
          end
        end
      end
    end
  end
end