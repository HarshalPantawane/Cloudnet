module "s3" {
  source = "../modules/s3"
  env_name = var.env_name
  bucket_region = var.bucket_region
}