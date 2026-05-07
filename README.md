# infra-as-code

Terraform modules for provisioning HPC compute clusters on Azure. Parameterized environments (dev/prod) with reusable modules for compute nodes, networking, and NFS storage.

## Structure

```
modules/
  compute-node/     # RHEL VMs + scratch disks + managed identity
  networking/       # VNet, subnets, NSGs for cluster isolation
  storage-nfs/      # Azure NetApp Files or NFS server VM

environments/
  dev/              # 4x Standard_D8s_v5 nodes
  prod/             # 32x Standard_HB120rs_v3 (HPC, InfiniBand-capable)
```

## Usage

```bash
# Deploy dev cluster
./scripts/apply.sh dev plan
./scripts/apply.sh dev apply

# Deploy prod cluster
./scripts/apply.sh prod plan
./scripts/apply.sh prod apply
```

## What gets created

- RHEL 9 VMs (HPC-optimized SKUs for prod)
- System-assigned managed identities per node
- 512GB to 1TB Premium SSD scratch disks per node
- Private VNet with cluster subnet

## Backend

Remote state in Azure Storage (per environment). Configure in `environments/<env>/backend.tf`.

## Tech
`Terraform` · `Azure` · `RHEL 9` · `HPC VM SKUs` · `Managed Identity` · `Azure NetApp Files`
