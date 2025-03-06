
resource "aws_codebuild_project" "codebuild" {
  name          = "${var.app_name}-build"
  description   = "CodeBuild project for ${var.app_name}"
  build_timeout = var.build_timeout
  service_role  = aws_iam_role.codebuild_role.arn

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.repo}.git"
    buildspec       = var.buildspec
    git_clone_depth = 1
    report_build_status = true
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.image
    type                        = var.environment_type
    dynamic "environment_variable" {
      for_each = var.environment_variables
      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
      }
    }
  }

}

resource "aws_codebuild_webhook" "codebuild_webhook" {
  project_name = aws_codebuild_project.codebuild.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = var.webhook_event_type
      pattern = var.webhook_event_pattern
    }

    filter {
      type    = "BASE_REF"
      pattern = var.branch
    }
  }
}

output "codebuild_project" {
  value = aws_codebuild_project.codebuild 
}
