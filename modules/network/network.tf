#VIRTUAL NETWORK
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  address_space       = var.vnet-add-range
  location            = var.rg-location
  resource_group_name = var.rg-name
}
# web tier subnet
resource "azurerm_subnet" "web-subnet" {
  name                 = var.web-subnet-name
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.web-subnet-add-range
}
#app tier subnet
resource "azurerm_subnet" "app-subnet" {
  name                 = var.app-subnet-name
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.app-subnet-add-range
}
#data tier subnet
resource "azurerm_subnet" "data-subnet" {
  name                 = var.data-subnet-name
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.data-subnet-add-range
}
#management server subnet
resource "azurerm_subnet" "management-subnet" {
  name                 = var.management-subnet-name
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.management-subnet-add-range
}
resource "azurerm_public_ip" "jump-public-ip" {
  name                = var.jump-public-ip-name
  resource_group_name = var.rg-name
  location            = var.rg-location
  allocation_method   = "Static"

}
resource "azurerm_network_interface" "web-nic" {
  name                = "web-tier-nic"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "management-nic" {
  name                = "management-nic"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.management-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jump-public-ip.id
  }
}
resource "azurerm_network_interface" "app-nic" {
  name                = "app-tier-nic"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "data-nic" {
  name                = "data-tier-nic"
  location            = var.rg-location
  resource_group_name = var.rg-name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.data-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_security_group" "web-nsg" {
  name                = "web-nsg-rule"
  location            = var.rg-location
  resource_group_name = var.rg-name

  security_rule {
    name                       = "http-allow"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.1.0/24"
  }
  security_rule {
    name                       = "https-allow"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "app-nsg" {
  name                = "app-nsg-rule"
  location            = var.rg-location
  resource_group_name = var.rg-name

  security_rule {
    name                       = "deny"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "data-nsg" {
  name                = "data-nsg-rule"
  location            = var.rg-location
  resource_group_name = var.rg-name

  security_rule {
    name                       = "deny"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_security_group" "management-nsg" {
  name                = "management-nsg-rule"
  location            = var.rg-location
  resource_group_name = var.rg-name

  security_rule {
    name                       = "allow-rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.4.0/24"
  }
}
resource "azurerm_network_interface_backend_address_pool_association" "external" {
  network_interface_id    = azurerm_network_interface.web-nic.id
  ip_configuration_name   = "external-lb-nic-config"
  backend_address_pool_id = azurerm_lb_backend_address_pool.external-backend-address-pool.id
}
resource "azurerm_network_interface_backend_address_pool_association" "internal" {
  network_interface_id    = azurerm_network_interface.app-nic.id
  ip_configuration_name   = "internal-lb-nic-config"
  backend_address_pool_id = azurerm_lb_backend_address_pool.internal-backend-address-pool.id
}