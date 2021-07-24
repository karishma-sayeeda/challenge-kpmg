#Availabilty set for web tier
resource "azurerm_availability_set" "web-av-set" {
  name                          = var.web-av-set-name
  location                      = var.rg-location
  resource_group_name           = var.rg-name
  
}
#Availability set for app tier
resource "azurerm_availability_set" "app-av-set" {
  name                          = var.app-av-set-name
  location                      = var.rg-location
  resource_group_name           = var.rg-name
  }
#Availability set for data tier
resource "azurerm_availability_set" "data-av-set" {
  name                          = var.data-av-set-name
  location                      = var.rg-location
  resource_group_name           = var.rg-name
  }
#web tier VM
resource "azurerm_windows_virtual_machine" "web-vm" {
  name                = "web-tier-vm"
  resource_group_name = var.rg-name
  location            = var.rg-location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = azurerm_availability_set.web-av-set.id
  network_interface_ids = [
    azurerm_network_interface.web-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
resource "azurerm_windows_virtual_machine" "app-vm" {
  name                = "app-tier-vm"
  resource_group_name = var.rg-name
  location            = var.rg-location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = azurerm_availability_set.app-av-set.id
  network_interface_ids = [
    azurerm_network_interface.app-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
resource "azurerm_windows_virtual_machine" "data-vm" {
  name                = "data-tier-vm"
  resource_group_name = var.rg-name
  location            = var.rg-location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  availability_set_id = azurerm_availability_set.data-av-set.id
  network_interface_ids = [
    azurerm_network_interface.data-nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}