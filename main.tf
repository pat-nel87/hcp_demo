# Configure the Azure Provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "rg-terraform-trial"
  location = "East US"

  tags = {
    environment = "trial"
    project     = "terraform-learning"
  }
}

# Create a storage account
resource "azurerm_storage_account" "main" {
  name                     = "sttftrialunique${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"  # Locally Redundant Storage (cheapest)

  # Enable public access (be careful in production)
  public_network_access_enabled = true
  
  tags = {
    environment = "trial"
    project     = "terraform-learning"
  }
}

# Create a random suffix for storage account name (must be globally unique)
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Create a storage container (like an S3 bucket)
resource "azurerm_storage_container" "main" {
  name                  = "terraform-trial-container"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# Output some useful information
output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.main.name
}

output "storage_account_name" {
  description = "Name of the created storage account"
  value       = azurerm_storage_account.main.name
}

output "storage_account_primary_endpoint" {
  description = "Primary blob endpoint for the storage account"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}