provider "azurerm" {
  features {}
}
module "resourcegroup" {
  source         = "./modules/resource-group"
  name           = var.rg-name
  location       = var.rg-location
}
module "networking" {
  source         = "./modules/network"
  location       = module.resourcegroup.location
  resource_group = module.resourcegroup.name
  vnet_name      = var.vnet-name
  vnet_add       = var.vnet-add-range
  websubnet_name = var.web-subnet-name
  appsubnet_name = var.app-subnet-name
  datasubnet_name = var.data-subnet-name
  websubnet_add  = var.web-subnet-add-range
  appsubnet_add  = var.app-subnet-add-range
  datasubnet_add = var.data-subnet-add-rnge
  managementsubnet_name = var.management-subnet-name
  managementsubnet_add  = var.management-subnet-add-rnge
  managementpublicip_name = var.jump-public-ip-name
  externallb_name  = var.external-lb-name
  internallb_name  = var.internal-lb-name
  lbprivate_ip_add = var.lb-private-ip-add
}
module "compute" {
  source          = "./modules/compute"
  location       = module.resourcegroup.location
  resource_group = module.resourcegroup.name
  web_tier_av_set = var.web-av-set-name
  app_tier_av_set = var.app-av-set-name
  data_tier_av_set = var.data-av-set-name
}
