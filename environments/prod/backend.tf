terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatehpcprod"
    container_name       = "tfstate"
    key                  = "hpc-prod.tfstate"
  }
}
