resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = "API for reading data from the database"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id               = aws_api_gateway_rest_api.api.id
  resource_id               = aws_api_gateway_resource.resource.id
  http_method               = aws_api_gateway_method.method.http_method
  integration_http_method   = "POST"
  type                      = "AWS_PROXY"
  uri                       =  var.lambda_invoke_arn
}
