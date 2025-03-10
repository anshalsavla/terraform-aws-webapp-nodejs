resource "aws_iam_role" "codebuild_role" {
  name = "${var.app_name}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name   = "${var.app_name}-codebuild--policy"
  role   = aws_iam_role.codebuild_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "codebuild:CreateWebhook",
          "codebuild:DeleteWebhook",
          "codebuild:UpdateWebhook",   
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion",
          "s3:GetBucketLocation"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetProjects",
          "codebuild:StopBuild",
          "codebuild:BatchGetBuilds",
        ]
        Effect   = "Allow"
        Resource = "*"
      },

      {
        Action = [
         "codestar-connections:GetConnectionToken",
         "codestar-connections:GetConnection",
         "codeconnections:GetConnectionToken",
         "codeconnections:GetConnection",
         "codeconnections:UseConnection"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

output "role" {
  value = aws_iam_role.codebuild_role
}