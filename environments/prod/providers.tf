############################################################################################################
# Title: Swiss Army Kube source code                                                                       #
# Author: Provectus developers                                                                             #
# Date: 2021                                                                                               #
# Code version: 0.1.1                                                                                      #
# Availability: https://github.com/provectus/swiss-army-kube/tree/10fc77114af1d65ee18b84cbcc38aa08d1567c89 #
############################################################################################################

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}