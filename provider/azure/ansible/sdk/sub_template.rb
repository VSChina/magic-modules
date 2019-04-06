module Provider
  module Azure
    module Ansible
      module SDK
        module SubTemplate
          def build_class_instance_variable_init(object, indentation = 8)
            result = compile 'templates/azure/ansible/sdk/class_instance_variable_init.erb', 1
            indent result, indentation
          end

          def build_sdk_method_invocation(sdk_client, sdk_op_def, indentation = 12)
            result = compile 'templates/azure/ansible/sdk/method_invocation.erb', 1
            indent result, indentation
          end
        end
      end
    end
  end
end