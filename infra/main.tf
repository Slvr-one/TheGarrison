module "network" {
  source = "./modules/network"
}

module "gke" {
  source = "./modules/gke"

  vpc = module.network.vpc
  private_subnet = module.network.private_subnet
}