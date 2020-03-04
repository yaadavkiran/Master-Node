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
  default = "/home/kiran/.ssh/authorized_keys"
}

variable "gce_ssh_user" {
  default = "kiran"
}

variable "vm_name" {
    type = "list"
  default = ["master","workernode1","workernode2"]
}
