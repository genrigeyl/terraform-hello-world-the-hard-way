terraform {
  required_version = ">= 1.7"
}

resource "null_resource" "hello_world_letters" {
  for_each = { for item in local.letters : item.key => item }
  provisioner "local-exec" {
    command = "echo '${each.value.value}'"
    quiet   = true
  }
}

resource "null_resource" "hello_world_word" {
  provisioner "local-exec" {
    command = "echo '${join("", null_resource.hello_world_letters[*].id)}'"
  }
}
