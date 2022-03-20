resource "aws_lambda_function" "lambda" {
  filename          = data.archive_file.source_code.output_path
  function_name     = local.identifier
  role              = aws_iam_role.lambda.arn
  handler           = var.lambda_handler
  source_code_hash  = data.archive_file.source_code.output_base64sha256
  runtime           = var.lambda_runtime
  timeout           = var.lambda_timeout

  environment {
    variables = var.env_variables
  }

  tags = {
    environment = lower(var.environment)
    application = lower(var.application)
    cost-center = lower(var.cost-center)
    deployed-by = lower(var.deployed-by)
  }

  depends_on = [null_resource.git_clone]
}

resource "aws_lambda_permission" "sns_execution" { 
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = local.identifier
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.notification.arn
}

resource "null_resource" "git_clone" {
  triggers = {
    on_version_change = var.git_version
  }

  provisioner "local-exec" {
    command = "git clone ${var.git_url} ./lambda"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm -rf ./lambda"
  }
    
}

  data "archive_file" "source_code" {
  type          = "zip"
  source_dir    = "./lambda"
  output_path   = "./lambda.zip"

  depends_on = [null_resource.git_clone]
}
