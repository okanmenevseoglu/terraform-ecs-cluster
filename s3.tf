# Creates a private S3 bucket to be used by the ECS cluster
resource "aws_s3_bucket" "nginx-container-bucket" {
  bucket = "nginx-container-bucket"
  acl = "private"
}
