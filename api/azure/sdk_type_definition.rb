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

module Api
  module Azure
    class SDKTypeDefinition < Api::Object
      attr_reader :id_portion
      attr_reader :applicable_to
      attr_reader :empty_value_sensitive
      attr_reader :go_variable_name
      attr_reader :go_field_name
      attr_reader :go_type_name
      attr_reader :is_pointer_type
      attr_reader :python_parameter_name
      attr_reader :python_variable_name
      attr_reader :python_field_name

      def validate
        super
        check :id_portion, type: ::String
        check_ext :applicable_to, type: ::Array, item_type: ::String, item_allowed: ['go', 'python'], default: ['go', 'python']
        check :empty_value_sensitive, type: :boolean, default: false
        check :go_variable_name, type: ::String
        check :go_field_name, type: ::String
        check :go_type_name, type: ::String
        check :is_pointer_type, type: :boolean, default: false
        check :python_parameter_name, type: ::String
        check :python_variable_name, type: ::String
        check :python_field_name, type: ::String
      end

      def merge_overrides!(overrides)
        @id_portion = overrides.id_portion unless overrides.id_portion.nil?
        @empty_value_sensitive = overrides.empty_value_sensitive unless overrides.empty_value_sensitive.nil?
        @go_variable_name = overrides.go_variable_name unless overrides.go_variable_name.nil?
        @go_field_name = overrides.go_field_name unless overrides.go_field_name.nil?
        @go_type_name = overrides.go_type_name unless overrides.go_type_name.nil?
        @is_pointer_type = overrides.is_pointer_type unless overrides.is_pointer_type.nil?
        @python_parameter_name = overrides.python_parameter_name unless overrides.python_parameter_name.nil?
        @python_variable_name = overrides.python_variable_name unless overrides.python_variable_name.nil?
        @python_field_name = overrides.python_field_name unless overrides.python_field_name.nil?
      end

      class BooleanObject < SDKTypeDefinition
      end

      class IntegerObject < SDKTypeDefinition
      end

      class Integer32Object < SDKTypeDefinition
      end

      class Integer64Object < SDKTypeDefinition
      end

      class Integer32ArrayObject < SDKTypeDefinition
      end

      class Integer64ArrayObject < SDKTypeDefinition
      end

      class FloatObject < SDKTypeDefinition
      end

      class FloatArrayObject < FloatObject
      end

      class StringObject < SDKTypeDefinition
      end

      class EnumObject < SDKTypeDefinition
        attr_reader :go_enum_type_name
        attr_reader :go_enum_const_prefix

        def validate
          super
          check :go_enum_type_name, type: ::String
          check :go_enum_const_prefix, type: ::String, default: ''
        end

        def merge_overrides!(overrides)
          super
          @go_enum_type_name = overrides.go_enum_type_name unless overrides.go_enum_type_name.nil?
          @go_enum_const_prefix = overrides.go_enum_const_prefix unless overrides.go_enum_const_prefix.nil?
        end
      end

      class EnumArrayObject < EnumObject
      end

      class ISO8601DurationObject < StringObject
      end

      class ISO8601DateTimeObject < SDKTypeDefinition
      end

      class ComplexObject < SDKTypeDefinition
      end

      class StringArrayObject < SDKTypeDefinition
      end

      class ComplexArrayObject < ComplexObject
      end

      class StringMapObject < SDKTypeDefinition
      end

    end
  end
end
