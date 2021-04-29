resource "aws_s3_bucket_object" "artifacts" {
  bucket       = aws_s3_bucket.pcluster_bucket.id
  key          = "${var.name}/custom_resources_code/artifacts.zip"
  source       = "${path.module}/artifacts/artifacts.zip"
  content_type = "application/zip"
  etag         = filemd5("${path.module}/artifacts/artifacts.zip")
}
