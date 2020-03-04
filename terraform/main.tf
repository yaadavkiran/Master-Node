variable "var" {
     default = "test"
}

output "out1" {
  value = "${var.var}"
}
