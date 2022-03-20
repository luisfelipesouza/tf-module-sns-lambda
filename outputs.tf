output "sns_topic_arn"{
    value = aws_sns_topic.notification.arn
}
output "sns_topic_name" {
    value = aws_sns_topic.notification.name
}
output "lambda_arn"{
    value = aws_lambda_function.lambda.arn
}
output "lambda_name"{
    value = aws_lambda_function.lambda.function_name
}