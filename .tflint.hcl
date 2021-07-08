############################################################################################################
# Title: Swiss Army Kube source code                                                                       #
# Author: Kharlamov, D. and Gimadiev, R.                                                                   #
# Date: 2021                                                                                               #
# Code version: 0.1.1                                                                                      #
# Availability: https://github.com/provectus/swiss-army-kube/tree/10fc77114af1d65ee18b84cbcc38aa08d1567c89 #
############################################################################################################

plugin "aws" {
  enabled = true
  deep_check = true
}

config {
  module = true
  deep_check = false
  force = false
  disabled_by_default = false
}

rule "aws_instance_invalid_type" {
  enabled = true
}

rule "aws_instance_previous_type" {
  enabled = true
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = true
}