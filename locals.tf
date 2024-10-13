locals {
  letters = flatten([
    for key, item in var.letters : {
      key = key
      value = item.value
    }
  ])
}

