#Resource group parameters
rg-name                     = "Test-rg"
rg-location                 = "eastus2"
#Compute Parameters
web-av-set-name             = "web-tier-av-st"
app-av-set-name             = "app-tier-av-st"
data-av-set-name            = "data-tier-av-st"
#Network parameters
vnet-name                   = "3-tier-vnet"
vnet-add-range              = ["10.0.0.0/16"]
web-subnet-name             = "web-tier-subnet"
web-subnet-add-range        = ["10.0.1.0/24"]       
app-subnet-name             = "app-tier-subnet"
app-subnet-add-range        = ["10.0.2.0/24"]        
data-subnet-name            = "data-tier-subnet"
data-subnet-add-range       = ["10.0.3.0/24"]        
management-subnet-name      = "management-server-subnet"
management-subnet-add-range = ["10.0.0.128/25"]
jump-public-ip-name         = "jump-server-public-ip"     
#Loadbalancer parameters
external-lb-name            = "external-lb"
internal-lb-name            = "internal-lb"
lb-private-ip-add           = "10.0.2.8"