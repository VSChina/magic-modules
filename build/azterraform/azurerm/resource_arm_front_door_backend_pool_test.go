// ----------------------------------------------------------------------------
//
//     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
//
// ----------------------------------------------------------------------------
//
//     This file is automatically generated by Magic Modules and manual
//     changes will be clobbered when the file is regenerated.
//
//     Please read more about how to change this file in
//     .github/CONTRIBUTING.md.
//
// ----------------------------------------------------------------------------

package azurerm

import (
    "fmt"
    "testing"

    "github.com/hashicorp/terraform/helper/resource"
    "github.com/hashicorp/terraform/terraform"
    "github.com/terraform-providers/terraform-provider-azurerm/azurerm/helpers/tf"
    "github.com/terraform-providers/terraform-provider-azurerm/azurerm/utils"
)


func testCheckAzureRMFrontDoorBackendPoolExists(resourceName string) resource.TestCheckFunc {
    return func(s *terraform.State) error {
        rs, ok := s.RootModule().Resources[resourceName]
        if !ok {
            return fmt.Errorf("Front Door Backend Pool not found: %s", resourceName)
        }

        name := rs.Primary.Attributes["name"]
        resourceGroup := rs.Primary.Attributes["resource_group_name"]
        frontDoor := rs.Primary.Attributes["frontdoor_name"]

        client := testAccProvider.Meta().(*ArmClient).frontdoorBackendPoolsClient
        ctx := testAccProvider.Meta().(*ArmClient).StopContext

        if resp, err := client.Get(ctx, resourceGroup, frontDoor, name); err != nil {
            if utils.ResponseWasNotFound(resp.Response) {
                return fmt.Errorf("Bad: Front Door Backend Pool %q (Frontdoor Name %q / Resource Group %q) does not exist", name, frontDoor, resourceGroup)
            }
            return fmt.Errorf("Bad: Get on frontdoorBackendPoolsClient: %+v", err)
        }

        return nil
    }
}

func testCheckAzureRMFrontDoorBackendPoolDestroy(s *terraform.State) error {
    client := testAccProvider.Meta().(*ArmClient).frontdoorBackendPoolsClient
    ctx := testAccProvider.Meta().(*ArmClient).StopContext

    for _, rs := range s.RootModule().Resources {
        if rs.Type != "azurerm_front_door_backend_pool" {
            continue
        }

        name := rs.Primary.Attributes["name"]
        resourceGroup := rs.Primary.Attributes["resource_group_name"]
        frontDoor := rs.Primary.Attributes["frontdoor_name"]

        if resp, err := client.Get(ctx, resourceGroup, frontDoor, name); err != nil {
            if !utils.ResponseWasNotFound(resp.Response) {
                return fmt.Errorf("Bad: Get on frontdoorBackendPoolsClient: %+v", err)
            }
        }

        return nil
    }

    return nil
}