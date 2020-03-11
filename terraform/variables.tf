variable "project" {
     default = "first-project-269313"
}

variable "region" {
    default =  "asia-south1"
}

variable "zone" {
    default = "asia-south1-c"  
}

variable "prefix" {
    default = "nginx"
}

variable "gce_ssh_pub_key_file" {
  default = "/home/${gce_ssh_user}/.ssh/rsa_pub"
}

variable "gce_ssh_user" {
  default = "kiran"
}

variable "vm_master" {
    type = "list"
  default = ["master"]
}

variable "vm_worker" {
    type = "list"
  default = ["worker1","worker2"]
}
