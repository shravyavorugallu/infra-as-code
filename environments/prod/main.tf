module "compute_cluster" {
  source = "../../modules/compute-node"

  cluster_name        = "hpc-prod-01"
  resource_group_name = "rg-hpc-prod"
  location            = "westus2"
  node_count          = 32
  vm_size             = "Standard_HB120rs_v3"  # HPC-optimized with InfiniBand
  ssh_public_key      = var.ssh_public_key
  subnet_id           = module.networking.compute_subnet_id
  scratch_disk_size_gb = 1024

  tags = {
    Environment = "prod"
    ManagedBy   = "terraform"
    Team        = "hpc-ops"
  }
}

module "networking" {
  source              = "../../modules/networking"
  resource_group_name = "rg-hpc-prod"
  location            = "westus2"
  vnet_address_space  = ["10.0.0.0/16"]
  cluster_name        = "hpc-prod-01"
}
