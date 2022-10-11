resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = aws_lambda_function.foobar_lambda.function_name
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_cloudwatch_metric_alarm" "foobar_error_alarm" {
  alarm_name                = "foobar-lambda-errors-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "Errors"
  namespace                 = "AWS/Lambda"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "1"
  alarm_description         = "This metric monitors errors for the foobar lambda."
  insufficient_data_actions = []
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.foobar_errors.arn]
}
