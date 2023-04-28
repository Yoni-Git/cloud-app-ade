resource "aws_dynamodb_table" "app_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = var.hash_key
  attribute {
    name = "id"
    type = "S"
  }
}
