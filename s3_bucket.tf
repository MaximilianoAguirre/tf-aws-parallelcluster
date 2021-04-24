####################################################################
# S3 Bucket
# Required by AWS ParallelCluster to store cfn templates and scripts
####################################################################
resource "aws_s3_bucket" "pcluster_bucket" {
  bucket_prefix = "parallelcluster-${var.name}-"
  acl           = "private"

  versioning {
    enabled = true
  }

  tags = var.tags
}
