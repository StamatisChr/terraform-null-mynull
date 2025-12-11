terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    null = {
      source  = "hashicorp/null"
    }
    aws = {
      source  = "hashicorp/aws"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

# data "external" "myexternal" {
#   program = ["jq", "-n", "env"]
# }


variable "mycount" {
  default = 3
}

resource "random_pet" "pet1" {
  prefix = timestamp()
  length = 3
}

output "pet1" {
  value = random_pet.pet1.*.id
}

resource "null_resource" "null1" {
  count = var.mycount
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "echo ${random_pet.pet1.id}"
  }
}

output "null1" {
  value = null_resource.null1.*.id
}

resource "null_resource" "null2" {
  count = var.mycount
  triggers = {
    always_run = timestamp()
  }
}

output "null2" {
  value = null_resource.null2.*.id
}

resource "random_pet" "pet2" {
  count  = var.mycount
  prefix = timestamp()
}

output "pet2" {
  value = random_pet.pet2.*.id
}

resource "null_resource" "null3" {
  count = var.mycount
  triggers = {
    always_run = timestamp()
  }
}

output "null3" {
  value = null_resource.null3.*.id
}

resource "random_pet" "pet3" {
  count  = var.mycount
  prefix = timestamp()
}

output "pet3" {
  value = random_pet.pet3.*.id
}

resource "null_resource" "previous" {}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "30s"
}

# This resource will create (at least) 30 seconds after null_resource.previous
resource "null_resource" "next" {
  depends_on = [time_sleep.wait_30_seconds]
}
