####################################################################
# Compute fleet stack cfn template
####################################################################
locals {
  compute_fleet_data = {
    tags           = var.tags
    config_version = aws_s3_bucket_object.cluster_config.version_id
    config         = local.cluster_config
  }
}

data "http" "compute_fleet_template" {
  url = "https://${data.aws_region.current.name}-aws-parallelcluster.s3.${data.aws_region.current.name}.amazonaws.com/templates/compute-fleet-hit-substack-${local.version}.cfn.yaml"
}

module "compute_fleet_template_jinja_rendered" {
  source = "github.com/MaximilianoAguirre/tf-jinja-renderer"

  jinja_template = data.http.compute_fleet_template.body
  data           = jsonencode(local.compute_fleet_data)

  filters = [
    "${path.module}/jinja/filters.py"
  ]
}

resource "aws_s3_bucket_object" "compute_fleet_template" {
  bucket       = aws_s3_bucket.pcluster_bucket.id
  key          = "${var.name}/templates/compute-fleet-hit-substack.rendered.cfn.yaml"
  content      = module.compute_fleet_template_jinja_rendered.rendered_template
  content_type = "text/yaml"
  etag         = md5(module.compute_fleet_template_jinja_rendered.rendered_template)
}
