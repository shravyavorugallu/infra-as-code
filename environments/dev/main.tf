module "compute_cluster" {
  source = "../../modules/compute-node"

  cluster_name        = "hpc-dev-01"
  resource_group_name = "rg-hpc-dev"
  location            = "westus2"
  node_count          = 4
  vm_size             = "Standard_D8s_v5"
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.networking.compute_subnet_id
  scratch_disk_size_gb = 128

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

module "networking" {
  source              = "../../modules/networking"
  resource_group_name = "rg-hpc-dev"
  location            = "westus2"
  vnet_address_space  = ["10.1.0.0/16"]
  cluster_name        = "hpc-dev-01"
}
