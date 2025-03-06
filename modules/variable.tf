variable "app_name" {
    description = "The name of the WebApp"
    type        = string
  
}

variable "repo" {
    description = "The URL of the GitHub repository"
    type        = string
    default = "https://github.com/your-github-username/musician-app.git"
  
}

variable "buildspec" {
    description = "The path to the buildspec file"
    type        = string
    default = "../buildspec.yml"
  
}

variable "environment_variables" {
    description = "The environment variables for the build process."
    type = list(object({
        name=string, 
        value=string
    }))
    default = []
}

variable "compute_type" {
    description = "The compute type for the build process."
    type        = string
    default = "BUILD_LAMBDA_1GB"
}

variable "image" {
    description = "The image for the build process."
    type        = string
    default = "aws/codebuild/amazonlinux-x86_64-lambda-standard:nodejs14"
}

variable "environment_type" {
    description = "The environment type for the build process."
    type        = string
    default = "LINUX_CONTAINER"
}

variable "webhook_event_type" {
    description = "Webhook event type"
    type = string
    validation {
        condition = contains(["EVENT", "BASE_REF", "HEAD_REF", "ACTOR_ACCOUNT_ID", "FILE_PATH", "COMMIT_MESSAGE", "WORKFLOW_NAME", "TAG_NAME", "RELEASE_NAME"], var.webhook_event_type)
        error_message = "Invalid webhook event type"
    }
    default = "EVENT"
}

variable "webhook_event_pattern" {
    description = "Required) For a filter that uses EVENT type, a comma-separated string that specifies one event: PUSH, PULL_REQUEST_CREATED, PULL_REQUEST_UPDATED, PULL_REQUEST_REOPENED. PULL_REQUEST_MERGED, WORKFLOW_JOB_QUEUED works with GitHub & GitHub Enterprise only. For a filter that uses any of the other filter types, a regular expression."
    type = string
 
    default = null
  
}
variable "branch" {
    description = "The branch to trigger the build"
    type        = string
    default = "main"
  
}

variable "build_timeout" {
    description = "The build timeout in minutes"
    type        = number
    default = 5
  
}
