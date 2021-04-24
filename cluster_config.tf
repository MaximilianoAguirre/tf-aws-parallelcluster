####################################################################
# Cluster config S3 object
####################################################################
locals {
  cluster_config = {
    cluster = {
      label = "default"
      scaling = {
        label              = "10min"
        scaledown_idletime = 10
      }
      default_queue = "interactive"
      queue_settings = {
        interactive = {
          compute_type           = "ondemand"
          enable_efa             = false
          enable_efa_gdr         = false
          disable_hyperthreading = true
          placement_group        = null
          compute_resource_settings = {
            compute_small = {
              instance_type                          = "c5d.large"
              min_count                              = 0
              max_count                              = 3
              initial_count                          = 0
              spot_price                             = 0
              vcpus                                  = 1
              gpus                                   = 0
              network_interfaces                     = 1
              enable_efa                             = false
              enable_efa_gdr                         = false
              disable_hyperthreading                 = true
              disable_hyperthreading_via_cpu_options = true
            }
          }
        }
        large = {
          compute_type           = "ondemand"
          enable_efa             = false
          enable_efa_gdr         = false
          disable_hyperthreading = true
          placement_group        = null
          compute_resource_settings = {
            compute_small = {
              instance_type                          = "r5d.4xlarge"
              min_count                              = 0
              max_count                              = 3
              initial_count                          = 0
              spot_price                             = 0
              vcpus                                  = 8
              gpus                                   = 0
              network_interfaces                     = 1
              enable_efa                             = false
              enable_efa_gdr                         = false
              disable_hyperthreading                 = true
              disable_hyperthreading_via_cpu_options = true
            }
          }
        }
        medium = {
          compute_type           = "ondemand"
          enable_efa             = false
          enable_efa_gdr         = false
          disable_hyperthreading = true
          placement_group        = null
          compute_resource_settings = {
            compute_small = {
              instance_type                          = "r5d.xlarge"
              min_count                              = 0
              max_count                              = 3
              initial_count                          = 0
              spot_price                             = 0
              vcpus                                  = 2
              gpus                                   = 0
              network_interfaces                     = 1
              enable_efa                             = false
              enable_efa_gdr                         = false
              disable_hyperthreading                 = true
              disable_hyperthreading_via_cpu_options = true
            }
          }
        }
      }
      disable_cluster_dns = false
    }
  }
}

resource "aws_s3_bucket_object" "cluster_config" {
  bucket       = aws_s3_bucket.pcluster_bucket.id
  key          = "${var.name}/configs/cluster-config.json"
  content      = jsonencode(local.cluster_config)
  content_type = "application/json"
  etag         = md5(jsonencode(local.cluster_config))
}
