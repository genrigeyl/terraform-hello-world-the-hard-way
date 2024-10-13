terraform {
  required_version = ">= 1.7"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
  }
}

resource "null_resource" "hello_world_letters" {
  for_each = { for index, item in local.letters : item.key[index] => item }
  provisioner "local-exec" {
    command = "printf '${each.value.value}' >> /tmp/tf_hello_world.tf"
    quiet   = true
  }
}

data "local_file" "hello_world_word" {
  depends_on = [null_resource.hello_world_letters]
  filename   = "/tmp/tf_hello_world.tf"
}

resource "null_resource" "hello_word_whipe" {
  depends_on = [data.local_file.hello_world_word, null_resource.hello_world_letters]
  provisioner "local-exec" {
    command = "rm -f /tmp/tf_hello_world.tf"
  }
}
