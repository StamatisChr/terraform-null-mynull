terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    null = {
      source  = "hashicorp/null"
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
  value = 10
}
