variable "vnet-name" {
  type        = string
  description = "Name of the virtual network"
}
variable "vnet-add-range" {
  type        = list
  description = "cidr range of the virtual network"
}
variable "web-subnet-name" {
  type        = string
  description = "Name of the web tier subnet"
}
variable "web-subnet-add-range" {
  type        = list
  description = "cidr range of the web tier subnet"
}
variable "app-subnet-name" {
  type        = string
  description = "Name of the app tier subnet"
}
variable "app-subnet-add-range" {
  type        = list
  description = "cidr range of the app tier subnet"
}
variable "data-subnet-name" {
  type        = string
  description = "Name of the data tier subnet"
}
variable "data-subnet-add-range" {
  type        = list
  description = "cidr range of the data tier subnet"
}
variable "management-subnet-name" {
  type        = string
  description = "Name of the management server subnet"
}
variable "management-subnet-add-range" {
  type        = list
  description = "cidr range of the management server subnet"
}
variable "jump-public-ip-name" {
  type        = string
  description = "management server public ip name" 
}
variable "external-lb-name" {
    type        = string
    description = "name of external load balancer"
}
variable "internal-lb-name" {
    type        = string
    description = "name of internal load balancer"
}
variable "lb-private-ip-add" {
    type        = string
    description = "Private IP address of internal load balancer"
}