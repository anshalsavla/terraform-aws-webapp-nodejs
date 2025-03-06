resource "aws_codebuild_webhook" "codebuild_webhook" {
  project_name = aws_codebuild_project.codebuild.name
}

resource "github_repository_webhook" "git_repo_webhook" {
  active     = true
  events     = ["pull_request_created", "pull_request_updated"]
  name       = "${var.app_name}-webhook"
  repository = var.repo

  configuration {
    url          = aws_codebuild_webhook.codebuild_webhook.payload_url
    secret       = aws_codebuild_webhook.codebuild_webhook.secret
    content_type = "json"
    insecure_ssl = false
  }
}