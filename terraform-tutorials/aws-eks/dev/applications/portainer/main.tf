provider "kubernetes" {
  config_path = var.kubeconf_path

  config_context_auth_info = var.config_user
  config_context_cluster   = var.cluster_name
}

module "portainer" {
  source       = "jhole89/portainer/kubernetes"
  version      = "1.0.0"
}