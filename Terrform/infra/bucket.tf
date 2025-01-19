resource "aws_s3_bucket" "my_bucket" {
  bucket="${var.env}-crossroad-app-bucket"
  tags = {
    Name = "${var.env}-crossroad-app-bucket"
    Environment = var.env
  }

}
