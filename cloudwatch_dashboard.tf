####################################################################
# Cloudwatch dashboard stack cfn template
####################################################################
locals {
  cw_data = {
    config = merge(local.cluster_config, {
      json_params = {
        cluster = {
          dashboard = {
            enable = true
          }
        }
      }
      cfn_params = {
        NumberOfEBSVol = var.NumberOfEBSVol
        VolumeType     = var.VolumeType
        RAIDOptions    = var.RAIDOptions
        EFSOptions     = var.EFSOptions
        FSXOptions     = var.FSXOptions
        CWLogOptions   = var.CWLogOptions
        DCVOptions     = var.DCVOptions
        Scheduler      = var.Scheduler
        BaseOS         = var.BaseOS
      }
    })
  }
}

data "http" "cloudwatch_dashboard_template" {
  url = "https://${data.aws_region.current.name}-aws-parallelcluster.s3.${data.aws_region.current.name}.amazonaws.com/templates/cw-dashboard-substack-${local.version}.cfn.yaml"
}

module "cloudwatch_dashboard_template_jinja_rendered" {
  source = "github.com/MaximilianoAguirre/tf-jinja-renderer"

  jinja_template = data.http.cloudwatch_dashboard_template.body
  data           = jsonencode(local.cw_data)

  allow_undefined = true

  filters = [
    "${path.module}/jinja/filters.py"
  ]
}

resource "aws_s3_bucket_object" "cloudwatch_dashboard_template" {
  bucket       = aws_s3_bucket.pcluster_bucket.id
  key          = "${var.name}/templates/cw-dashboard-substack.rendered.cfn.yaml"
  content      = module.cloudwatch_dashboard_template_jinja_rendered.rendered_template
  content_type = "text/yaml"
  etag         = md5(module.cloudwatch_dashboard_template_jinja_rendered.rendered_template)
}
