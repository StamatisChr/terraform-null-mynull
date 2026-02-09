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

resource "null_resource" "null1" {
  count = var.mycount
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "echo ${random_pet.pet1.id}"
  }
}

resource "null_resource" "null2" {
  count = var.mycount
  triggers = {
    always_run = timestamp()
  }
}

resource "random_pet" "pet2" {
  count  = var.mycount
  prefix = timestamp()
}

resource "null_resource" "null3" {
  count = var.mycount
  triggers = {
    always_run = timestamp()
  }
}


resource "random_pet" "pet3" {
  count  = var.mycount
  prefix = timestamp()
}



output "pet3" {
  value = random_pet.pet3.*.id
}

output "null3" {
  value = null_resource.null3.*.id
}

output "version" {
  value = 9
}

resource "aws_security_group" "tfe_sg" {
  name        = "tfe_sg-test"
  description = "Allow inbound traffic and outbound traffic for TFE"
}


provider "aws" {
  region = "eu-west-1"
}
