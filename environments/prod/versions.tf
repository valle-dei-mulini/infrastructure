############################################################################################################
# Title: Swiss Army Kube source code                                                                       #
# Author: Provectus developers                                                                             #
# Date: 2021                                                                                               #
# Code version: 0.1.1                                                                                      #
# Availability: https://github.com/provectus/swiss-army-kube/tree/10fc77114af1d65ee18b84cbcc38aa08d1567c89 #
############################################################################################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.1.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.1.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.2.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
  required_version = ">= 0.14"
}