
resource "aws_codebuild_project" "codebuild" {
  name          = "${var.app_name}-build"
  description   = "CodeBuild project for ${var.app_name}"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  source {
    type            = "GITHUB"
    location        = var.repo
    buildspec       = var.buildspec
    git_clone_depth = 1
    report_build_status = true
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_LAMBDA_1GB"
    image                       = "aws/codebuild/amazonlinux-x86_64-lambda-standard:nodejs20"
    type                        = "LINUX_LAMBDA_CONTAINER"
    environment_variable {
      name  = "NODE_ENV"
      value = "test"
    }
  }

}

