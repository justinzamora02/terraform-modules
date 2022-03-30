package tests

import (
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformHelloWorldExample(t *testing.T) {
	t.Parallel()

	tempDirectory := test_structure.CopyTerraformFolderToTemp(t, "../", "vpc")
	planFilePath := filepath.Join(tempDirectory, "plan.out")

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../vpc",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"namespace": "jdb",
			"stage": "test",
			"name": "unit",
		},

		// Configure a plan file path so we can introspect the plan and make assertions about it.
		PlanFilePath: planFilePath,
	})

	plan := terraform.InitAndPlanAndShowWithStruct(t, terraformOptions)
	terraform.RequirePlannedValuesMapKeyExists(t, plan, "aws_vpc.main")
}