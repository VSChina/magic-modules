# Copyright 2019 Microsoft Corp.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'api/object'

module Provider
  module Azure
    module Terraform
      class Example < Api::Object
        module SubTemplate
          def build_test_hcl_from_example(example_name)
            random_vars = Array.new
            hcl = build_hcl_from_example(nil, example_name, "test", {}, random_vars, true)
            return hcl, random_vars
          end

          def build_documentation_hcl_from_example(example_name, name_hints)
            build_hcl_from_example(nil, example_name, "example", name_hints, [], true)
          end

          def build_hcl_from_example(product_name, example_name, id_hint, name_hints, random_vars, with_dependencies = false)
            hcl_raw = compile_template 'templates/azure/terraform/example/example_hcl.erb',
                                       example: get_example_by_names(example_name, product_name),
                                       random_variables: random_vars,
                                       resource_id_hint: id_hint,
                                       name_hints: name_hints,
                                       with_dependencies: with_dependencies
            context = ExampleContextBinding.new(id_hint, name_hints, random_vars)
            compile_string context.get_binding, hcl_raw
          end

          def build_documentation_import_resource_id(object, example_reference)
            compile_template 'templates/azure/terraform/example/import_resource_id.erb',
                             name_hints: example_reference.resource_name_hints,
                             object: object
          end

          def build_hcl_properties(properties_hash, indentation = 2)
            compile_template 'templates/azure/terraform/example/hcl_properties.erb',
                             properties: properties_hash,
                             indentation: indentation
          end
        end

        private

        class ExampleContextBinding
          attr_reader :my_binding
          attr_reader :name_hints
          attr_reader :random_variables

          def initialize(resource_id_hint, name_hints, random_vars)
            @my_binding = binding
            @my_binding.local_variable_set(:resource_id_hint, resource_id_hint)
            @name_hints = name_hints
            @random_variables = random_vars
          end

          def get_binding()
            @my_binding
          end

          def get_resource_name(name_hint, postfix)
            return name_hints[name_hint] if name_hints.has_key?(name_hint)
            @random_variables <<= RandomizedVariable.new(:AccDefaultInt)
            "acctest#{postfix}-#{@random_variables.last.format_string}"
          end

          def get_location()
            return name_hints["location"] if name_hints.has_key?("location")
            @random_variables <<= RandomizedVariable.new(:AccLocation)
            @random_variables.last.format_string
          end

          def get_storage_account_name()
            return name_hints["storageAccounts"] if name_hints.has_key?("storageAccounts")
            @random_variables <<= RandomizedVariable.new(:AccStorageAccount)
            "acctestsa#{@random_variables.last.format_string}"
          end

          def get_batch_account_name()
            return name_hints["batchAccounts"] if name_hints.has_key?("batchAccounts")
            @random_variables <<= RandomizedVariable.new(:AccBatchAccount)
            "acctestba#{@random_variables.last.format_string}"
          end
        end

        class RandomizedVariable
          attr_reader :variable_name
          attr_reader :parameter_name
          attr_reader :go_type
          attr_reader :create_expression
          attr_reader :format_string
          attr_reader :declare_order

          def initialize(type)
            case type
            when :AccDefaultInt
              @variable_name = "ri"
              @parameter_name = "rInt"
              @go_type = "int"
              @create_expression = "tf.AccRandTimeInt()"
              @format_string = "%d"
              @declare_order = 0
            when :AccStorageAccount
              @variable_name = "rs"
              @parameter_name = "rString"
              @go_type = "string"
              @create_expression = "strings.ToLower(acctest.RandString(11))"
              @format_string = "%s"
              @declare_order = 1
            when :AccBatchAccount
              @variable_name = "rs"
              @parameter_name = "rString"
              @go_type = "string"
              @create_expression = "strings.ToLower(acctest.RandString(11))"
              @format_string = "%s"
              @declare_order = 2
            when :AccLocation
              @variable_name = @parameter_name = "location"
              @go_type = "string"
              @create_expression = "acceptance.Location()"
              @format_string = "%s"
              @declare_order = 3
            end
          end
        end

      end
    end
  end
end
