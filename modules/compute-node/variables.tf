variable "cluster_name"       { type = string }
variable "resource_group_name" { type = string }
variable "location"           { type = string }
variable "node_count"         { type = number; default = 4 }
variable "vm_size"            { type = string; default = "Standard_D16s_v5" }
variable "admin_username"     { type = string; default = "clusteradmin" }
variable "ssh_public_key"     { type = string }
variable "subnet_id"          { type = string }
variable "os_disk_size_gb"    { type = number; default = 128 }
variable "scratch_disk_size_gb" { type = number; default = 512 }
variable "tags"               { type = map(string); default = {} }
