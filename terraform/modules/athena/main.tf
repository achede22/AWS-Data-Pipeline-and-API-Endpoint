resource "aws_athena_database" "challenge" {
  name   = var.database_name
  bucket = var.bucket_name # to store query results
}

resource "aws_athena_named_query" "create_passengers_table" {
  name     = "create_passengers_table"
  database = var.database_name

  query = <<-EOF
    CREATE EXTERNAL TABLE IF NOT EXISTS passengers (
      passenger_id int,
      flight_id int,
      name string,
      seat_number string
    )
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    LOCATION 's3://${var.bucket_name}/passengers.csv'
    TBLPROPERTIES ('skip.header.line.count'='1')
  EOF
}