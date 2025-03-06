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

