
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
    dynamic "filter" {
      for_each = var.filter_group
      content {
        type    = filter.value.type
        pattern = filter.value.pattern
      }
      
    }
  }
}

output "codebuild_project" {
  value = aws_codebuild_project.codebuild 
}
