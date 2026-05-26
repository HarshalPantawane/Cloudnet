resource "aws_s3_bucket" "dev_s3_fe" {
  bucket = "harshal-dev-${var.env_name}-fe-bucket"
  region = var.bucket_region

}

resource "aws_s3_bucket" "dev_s3_be" {  
  bucket = "harshal-dev-${var.env_name}-be-bucket-for-backend-server"
  region = var.bucket_region
}