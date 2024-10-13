output "hello_world" {
  value = data.local_file.hello_world_word.content
}
