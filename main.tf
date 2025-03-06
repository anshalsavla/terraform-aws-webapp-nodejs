module "music-app-build" {
    source = "./modules"
    app_name = "musician"
    repo = "anshalsavla/musician-app"
    buildspec = "buildspec.yml"
    compute_type = "BUILD_LAMBDA_1GB"
    image = "aws/codebuild/amazonlinux-x86_64-lambda-standard:nodejs14"
    environment_type = "LINUX_CONTAINER"
    webhook_event_type = "EVENT"
    webhook_event_pattern = "PULL_REQUEST_CREATED,PULL_REQUEST_UPDATED,PULL_REQUEST_REOPENED"
  
}