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

module Provider
  module Azure
    module Terraform
      module AccTest
        module SubTemplate

          def build_acctest_parameters_from_schema(sdk_op_def, properties, object, indentation = 8)
            compile_template 'templates/azure/terraform/acctest/parameters_from_schema.erb',
                             indentation: indentation,
                             sdk_op_def: sdk_op_def,
                             properties: properties,
                             object: object,
          end

        end
      end
    end
  end
end
