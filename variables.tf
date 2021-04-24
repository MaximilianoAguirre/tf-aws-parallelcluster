###################################################################
# Stack
###################################################################
variable "name" {
  type = string
}

variable "tags" {
  type    = map
  default = {}
}

###################################################################
# Cluster
###################################################################
# variable "cluster" {
#   type = object({
#     additional_cfn_template   = optional(string)
#     additional_iam_policies   = optional(string)
#     base_os                   = optional(string)
#     cluster_resource_bucket   = optional(string)
#     cluster_type              = optional(string)
#     compute_instance_type     = optional(string)
#     compute_root_volume_size  = optional(string)
#     custom_ami                = optional(string)
#     cw_log_settings           = optional(string)
#     dashboard_settings        = optional(string)
#     dcv_settings              = optional(string)
#     desired_vcpus             = optional(number)
#     disable_cluster_dns       = optional(bool)
#     disable_hyperthreading    = optional(bool)
#     ebs_settings              = optional(string)
#     ec2_iam_role              = optional(string)
#     efs_settings              = optional(string)
#     enable_efa                = optional(bool)
#     enable_efa_gdr            = optional(bool)
#     enable_intel_hpc_platform = optional(bool)
#     encrypted_ephemeral       = optional(bool)
#     ephemeral_dir             = optional(string)
#     extra_json                = optional(map(string))
#     fsx_settings              = optional(string)
#     iam_lambda_role           = optional(string)
#     initial_queue_size        = optional(number)
#     key_name                  = optional(string)
#     maintain_initial_size     = optional(bool)
#     master_instance_type      = optional(string)
#     master_root_volume_size   = optional(number)
#     max_queue_size            = optional(number)
#     max_vcpus                 = optional(number)
#     min_vcpus                 = optional(number)
#     placement                 = optional(string)
#     placement_group           = optional(string)
#     post_install              = optional(string)
#     post_install_args         = optional(list(string))
#     pre_install               = optional(string)
#     pre_install_args          = optional(list(string))
#     proxy_server              = optional(string)
#     queue_settings            = optional(list(string))
#     raid_settings             = optional(string)
#     s3_read_resource          = optional(string)
#     s3_read_write_resource    = optional(string)
#     scaling_settings          = optional(string)
#     scheduler                 = optional(string)
#     shared_dir                = optional(string)
#     spot_bid_percentage       = optional(number)
#     spot_price                = optional(number)
#     tags                      = optional(map(string))
#     template_url              = optional(string)
#     vpc_settings              = optional(string)
#   })
#   default = null
# }

###################################################################
# Cluster
###################################################################
variable "KeyName" {
  description = "Name of an existing EC2 KeyPair to enable SSH access to the instances using the default cluster user."
  type        = string
}

variable "MasterInstanceType" {
  description = "Head node EC2 instance type"
  type        = string
}

variable "ComputeInstanceType" {
  description = "ComputeFleet EC2 instance type"
  type        = string
  default     = "NONE"
}

variable "MinSize" {
  description = "Initial number of compute EC2 instances / vCpus to launch within the cluster."
  type        = number
  default     = 0
}

variable "DesiredSize" {
  description = "Desired number of compute EC2 instances / vCpus to launch within the cluster."
  type        = number
  default     = 0
}

variable "MaxSize" {
  description = "Maximum number of compute EC2 instances / vCpus to launch within the cluster."
  type        = number
  default     = 0
}

variable "ComputeSubnetId" {
  description = "ID of the Subnet you want to provision the Compute Servers into"
  type        = string
  default     = "NONE"

  #   validation {
  #     condition     = contains(["PERSISTENT_1", "SCRATCH_1", "SCRATCH_2"], var.type)
  #     error_message = "Wrong FSx for lustre type."
  #   }
}

variable "SpotPrice" {
  description = "Spot bid price for the ComputeFleet AutoScaling Group when the ClusterType = \"spot\". When awsbatch is the scheduler, this is spot bid percentage."
  type        = number
  default     = 0
}

variable "ClusterType" {
  description = "Type of cluster to launch. Can either be \"ondemand\" or \"spot\". Choosing \"spot\" will cause the ComputeFleet AutoScaling group to launch EC2 Spot instances. Default value is \"ondemand\"."
  type        = string
  default     = "ondemand"

  validation {
    condition     = contains(["ondemand", "spot"], var.ClusterType)
    error_message = "Must be a supported cluster type: ondemand, spot."
  }
}

variable "ProxyServer" {
  description = "hostname and port of HTTP proxy server for cfn-init, boto and yum i.e. proxy.example.com:8080"
  type        = string
  default     = "NONE"
}

variable "VolumeSize" {
  description = "Comma delimited list of size of EBS volume in GB, if creating a new one"
  type        = string
  default     = "NONE,NONE,NONE,NONE,NONE"
}

variable "VolumeType" {
  description = "Comma delimited list of type of volume to create either new or from snapshot"
  type        = string
  default     = "gp2,gp2,gp2,gp2,gp2"

  #   validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "MasterSubnetId" {
  description = "ID of the Subnet you want to provision the head node into"
  type        = string
}

variable "EBSSnapshotId" {
  description = "Comma delimited list of Id of EBS snapshot if using snapshot as source for volume"
  type        = string
  default     = "NONE,NONE,NONE,NONE,NONE"

  #   validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "CustomAMI" {
  description = "ID of a Custom AMI, to use instead of published AMI's"
  type        = string
  default     = "NONE"

  #   validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "VPCId" {
  description = "ID of the VPC you want to provision cluster into. Only used with UseVPCBase=false"
  type        = string
}

variable "AccessFrom" {
  description = "Lockdown SSH/HTTP access (default can be accessed from anywhere)"
  type        = string
  default     = "0.0.0.0/0"

  # validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "ComputeSubnetCidr" {
  description = "CIDR(s) for new backend subnet(s) i.e. 10.0.100.0/24. This is a comma-delimited list and can support multiple CIDR ranges for a multi-AZ cluster. The order and length of this list MUST match the AvailabilityZones parameter."
  type        = string
  default     = "NONE"

  # validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "UsePublicIps" {
  description = "Boolean flag to use public IP's for instances. If false, the VPC must be correctly setup to use NAT for all traffic."
  type        = bool
  default     = true
}

variable "VolumeIOPS" {
  description = "Comma delimited list of number of IOPS for volume type io1, io2 and gp3. Not used for other volume types."
  type        = string
  default     = "NONE,NONE,NONE,NONE,NONE"
}

variable "VolumeThroughput" {
  description = "Comma delimited list of number of Throughtput for volume type gp3. Not used for other volume types."
  type        = string
  default     = "125,125,125,125,125"
}

variable "PreInstallScript" {
  description = "Preinstall script URL. This is run before any host configuration."
  type        = string
  default     = "NONE"
}

variable "PostInstallScript" {
  description = "Postinstall script URL. This is run before any host configuration."
  type        = string
  default     = "NONE"
}

variable "S3ReadWriteResource" {
  description = "Addtional policy document to be added to EC2 IAM role created and assigned to all nodes."
  type        = string
  default     = "NONE"
}

variable "Placement" {
  description = "Type of placement requird in AWS ParallelCluster, it can either be cluster or compute."
  type        = string
  default     = "compute"

  validation {
    condition     = contains(["compute", "cluster"], var.Placement)
    error_message = "Must be a supported placement type: compute, cluster."
  }
}

variable "PlacementGroup" {
  description = "The name of an existing placement group"
  type        = string
  default     = "NONE"
}

variable "EncryptedEphemeral" {
  description = "Boolean flag to encrypt local ephemeral drives. The keys are in-memory and non-recoverable."
  type        = bool
  default     = false
}

variable "PreInstallArgs" {
  description = "Preinstall script args passed to the preinstall script."
  type        = string
  default     = "NONE"
}

variable "PostInstallArgs" {
  description = "Postinstall script args passed to the postinstall script."
  type        = string
  default     = "NONE"
}

variable "EBSEncryption" {
  description = "Comma delimited list of boolean flag to use EBS encryption for /shared volume. (Not to be used for snapshots)"
  type        = string
  default     = "false,false,false,false,false"
}

variable "EphemeralDir" {
  description = "The path/mountpoint for the ephemeral drive"
  type        = string
  default     = "/scratch"
}

variable "BaseOS" {
  description = "Base OS type for cluster AMI"
  type        = string
  default     = "alinux2"

  validation {
    condition = contains([
      "centos7",
      "centos8",
      "alinux",
      "alinux2",
      "ubuntu1604",
      "ubuntu1804"
    ], var.BaseOS)
    error_message = "Must be a supported base OS."
  }
}

variable "Architecture" {
  description = "Architecture to use when selecting default AMIs"
  type        = string
  default     = "x86_64"

  validation {
    condition     = contains(["x86_64", "arm64"], var.Architecture)
    error_message = "Must be either x86_64 or arm64."
  }
}

variable "ScaleDownIdleTime" {
  description = "Period in minutes without jobs after which compute node will terminate."
  type        = number
  default     = 10
}

variable "Scheduler" {
  description = "Cluster scheduler"
  type        = string
  default     = "slurm"

  validation {
    condition = contains([
      "sge",
      "torque",
      "slurm",
      "awsbatch"
    ], var.Scheduler)
    error_message = "Must be a supported scheduler."
  }
}

variable "SharedDir" {
  description = "The path/mountpoint for the shared drive"
  type        = string
  default     = "/shared"
}

variable "ClusterConfigMetadata" {
  description = "Cluster configuration metadata."
  type        = string
  default     = "{}"
}

variable "AdditionalSG" {
  description = "Additional VPC security group to be added to instances. Defaults to NONE"
  type        = string
  default     = "NONE"
}

variable "CustomChefCookbook" {
  description = "URL of custom cookbook that will override the default. This will be unpacked and then dependencies resolved with Berkshelf."
  type        = string
  default     = "NONE"
}

variable "ExtraJson" {
  description = "Extra json to be added to Chef dna.json"
  type        = string
  default     = "{}"
}

variable "EBSKMSKeyId" {
  description = "Comma delimited list of KMS ARN for customer created master key, will be used for EBS encryption"
  type        = string
  default     = "NONE,NONE,NONE,NONE,NONE"
}

variable "MasterRootVolumeSize" {
  description = "Size of head node EBS root volume in GB"
  type        = number
  default     = 25

  # validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "ComputeRootVolumeSize" {
  description = "Size of ComputeFleet EBS root volume in GB"
  type        = number
  default     = 25

  # validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "EC2IAMRoleName" {
  description = "Existing EC2 IAM role name"
  type        = string
  default     = "NONE"
}

variable "EC2IAMPolicies" {
  description = "Attach additional IAM Policies to the created Root Role"
  type        = string
  default     = "NONE"
}

variable "IAMLambdaRoleName" {
  description = "Existing IAM role name for Lambda functions"
  type        = string
  default     = "NONE"
}

variable "VPCSecurityGroupId" {
  description = "Existing VPC security group Id"
  type        = string
  default     = "NONE"

  # validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "EBSVolumeId" {
  description = "Comma delimited list of existing EBS volume Id"
  type        = string
  default     = "NONE,NONE,NONE,NONE,NONE"

  # validation {
  #     condition     = contains(["ondemand", "spot"], var.ClusterType)
  #     error_message = "Must be a supported cluster type: ondemand, spot"
  #   }
}

variable "AdditionalCfnTemplate" {
  description = "A second CloudFormation template to launch with the cluster"
  type        = string
  default     = "NONE"
}

variable "ResourcesS3Bucket" {
  description = "S3 bucket where resources needed by the stack are located. The bucket gets deleted on stack deletion if it is not user-provided."
  type        = string
}

# variable "ArtifactS3RootDirectory" {
#   description = "S3 bucket where resources needed by the stack are located. The bucket gets deleted on stack deletion if it is not user-provided."
#   type        = string
# }

variable "RemoveBucketOnDeletion" {
  description = "Parameter to control if bucket is removed on cluster deletion. pcluster created buckets are alway removed, user provided buckets are kept."
  type        = string
  default     = true
}

variable "RAIDOptions" {
  description = "Comma Separated List of RAID related options, 9 parameters in total, [shared_dir,raid_type,num_of_raid_volumes,volume_type,volume_size,volume_iops,encrypted,ebs_kms_key_id,volume_throughput]"
  type        = string
  default     = "NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE"
}

variable "NumberOfEBSVol" {
  description = "Number of EBS Volumes the user requested, up to 5"
  type        = number
  default     = 1
}

variable "FSXOptions" {
  description = "Comma separated list of FSx related options, 17 parameters in total, [shared_dir,fsx_fs_id,storage_capacity,fsx_kms_key_id,imported_file_chunk_size,export_path,import_path,weekly_maintenance_start_time,deployment_type,per_unit_storage_throughput,daily_automatic_backup_start_time,automatic_backup_retention_days,copy_tags_to_backups,fsx_backup_id,auto_import_policy,storage_type,drive_cache_type]"
  type        = string
  default     = "NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE"
}

variable "EFSOptions" {
  description = "Comma separated list of EFS related options, 9 parameters in total, [shared_dir,efs_fs_id,performance_mode,efs_kms_key_id,provisioned_throughput,encrypted,throughput_mode,exists_valid_head_node_mt,exists_valid_compute_mt]"
  type        = string
  default     = "NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE,NONE"
}

variable "Cores" {
  description = "Comma seperated string of [head node cores], [compute cores], [head node instance type supports disabling hyperthreading via CPU options], [compute instance type supports disabling hyperthreading via CPU options]."
  type        = string
  default     = "NONE,NONE,NONE,NONE"
}

variable "EFA" {
  description = "Enable EFA on the compute nodes, enable_efa = compute"
  type        = string
  default     = "NONE"
}

variable "EFAGDR" {
  description = "Enable EFA GPUDirect Support on the compute nodes, enable_efa_gdr = compute"
  type        = string
  default     = "NONE"
}

variable "DCVOptions" {
  description = "Comma separated list of NICE DCV related options, 3 parameters in total, [enabled,port,access_from]"
  type        = string
  default     = "NONE,NONE,NONE"
}

variable "IntelHPCPlatform" {
  description = "Enable Intel HPC Platform packages."
  type        = bool
  default     = false
}

variable "CWLogOptions" {
  description = "Comma separated list of CloudWatch logging, 2 parameters in total, [enabled, retention_days]"
  type        = string
  default     = "true,14"
}

variable "NetworkInterfacesCount" {
  description = "Comma separated string of [head node network interfaces], [compute network interfaces]."
  type        = string
  default     = "1,1"
}
