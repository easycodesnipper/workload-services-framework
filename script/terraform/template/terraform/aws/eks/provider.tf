#
# Apache v2 license
# Copyright (C) 2023 Intel Corporation
# SPDX-License-Identifier: Apache-2.0
#
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "= 5.63.0"
    }
    template = {
      source = "hashicorp/template"
      version = "= 2.2.0"
    }
    null = {
      source = "hashicorp/null"
      version = "= 3.2.1"
    }
  }
}

locals {
  region = var.region!=null?var.region:replace(var.zones[0],"/(.*)[a-z]$/","$1")
}

provider "aws" {
  region = local.region
  profile = var.profile

  default_tags {
    tags = var.common_tags
  }
}
