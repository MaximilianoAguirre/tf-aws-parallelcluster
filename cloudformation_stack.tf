# resource "aws_cloudformation_stack" "cluster" {
#   name = "parallelcluster-${var.name}"

#   template_url = "https://${data.aws_region.current.name}-aws-parallelcluster.s3.${data.aws_region.current.name}.amazonaws.com/templates/aws-parallelcluster-${local.version}.cfn.json"

#   parameters = {
#     KeyName                 = var.KeyName
#     MasterInstanceType      = var.MasterInstanceType
#     ComputeInstanceType     = var.ComputeInstanceType
#     MinSize                 = var.MinSize
#     DesiredSize             = var.DesiredSize
#     MaxSize                 = var.MaxSize
#     ComputeSubnetId         = var.ComputeSubnetId
#     SpotPrice               = var.SpotPrice
#     ClusterType             = var.ClusterType
#     ProxyServer             = var.ProxyServer
#     VolumeSize              = var.VolumeSize
#     VolumeType              = var.VolumeType
#     MasterSubnetId          = var.MasterSubnetId
#     AvailabilityZone        = data.aws_subnet.master_subnet.availability_zone
#     EBSSnapshotId           = var.EBSSnapshotId
#     CustomAMI               = var.CustomAMI
#     VPCId                   = var.VPCId
#     AccessFrom              = var.AccessFrom
#     ComputeSubnetCidr       = var.ComputeSubnetCidr
#     UsePublicIps            = var.UsePublicIps ? "true" : "false"
#     VolumeIOPS              = var.VolumeIOPS
#     VolumeThroughput        = var.VolumeThroughput
#     PreInstallScript        = var.PreInstallScript
#     PostInstallScript       = var.PostInstallScript
#     S3ReadWriteResource     = var.S3ReadWriteResource
#     Placement               = var.Placement
#     PlacementGroup          = var.PlacementGroup
#     EncryptedEphemeral      = var.EncryptedEphemeral ? "true" : "false"
#     PreInstallArgs          = var.PreInstallArgs
#     PostInstallArgs         = var.PostInstallArgs
#     EBSEncryption           = var.EBSEncryption
#     EphemeralDir            = var.EphemeralDir
#     BaseOS                  = var.BaseOS
#     Architecture            = var.Architecture
#     ScaleDownIdleTime       = var.ScaleDownIdleTime
#     Scheduler               = var.Scheduler
#     SharedDir               = var.SharedDir
#     ClusterConfigMetadata   = var.ClusterConfigMetadata
#     AdditionalSG            = var.AdditionalSG
#     CustomChefCookbook      = var.CustomChefCookbook
#     ExtraJson               = var.ExtraJson
#     EBSKMSKeyId             = var.EBSKMSKeyId
#     MasterRootVolumeSize    = var.MasterRootVolumeSize
#     ComputeRootVolumeSize   = var.ComputeRootVolumeSize
#     EC2IAMRoleName          = var.EC2IAMRoleName
#     EC2IAMPolicies          = var.EC2IAMPolicies
#     IAMLambdaRoleName       = var.IAMLambdaRoleName
#     VPCSecurityGroupId      = var.VPCSecurityGroupId
#     EBSVolumeId             = var.EBSVolumeId
#     AdditionalCfnTemplate   = var.AdditionalCfnTemplate
#     ResourcesS3Bucket       = aws_s3_bucket.pcluster_bucket.id
#     ArtifactS3RootDirectory = var.name
#     RemoveBucketOnDeletion  = var.RemoveBucketOnDeletion
#     RAIDOptions             = var.RAIDOptions
#     NumberOfEBSVol          = var.NumberOfEBSVol
#     FSXOptions              = var.FSXOptions
#     EFSOptions              = var.EFSOptions
#     Cores                   = var.Cores
#     EFA                     = var.EFA
#     EFAGDR                  = var.EFAGDR
#     DCVOptions              = var.DCVOptions
#     IntelHPCPlatform        = var.IntelHPCPlatform ? "true" : "false"
#     CWLogOptions            = var.CWLogOptions
#     NetworkInterfacesCount  = var.NetworkInterfacesCount
#   }

#   capabilities = ["CAPABILITY_IAM"]
#   on_failure   = "DELETE"

#   tags = var.tags
# }
