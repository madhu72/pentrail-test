# v2.0: hardened infrastructure.
#
# The v1.0 security group is gone rather than patched: ingress moved behind a
# managed load balancer, so an unattached group would be dead configuration.
#
# Tags are written inline on every resource rather than pulled from a `locals`
# block. Static analysers evaluate the literal HCL and do not resolve
# `local.tags`, so a shared map reads to them as an untagged resource.

resource "aws_s3_bucket" "logs" {
  bucket = "pentrail-test-logs"

  tags = {
    Name        = "pentrail-test-logs"
    Project     = "pentrail-test"
    Environment = "demo"
    ManagedBy   = "terraform"
    Owner       = "security-demo"
  }
}

resource "aws_s3_bucket_acl" "logs" {
  bucket = aws_s3_bucket.logs.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_logging" "logs" {
  bucket        = aws_s3_bucket.logs.id
  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "self/"
}

resource "aws_s3_bucket_public_access_block" "logs" {
  bucket                  = aws_s3_bucket.logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "data" {
  bucket = "pentrail-test-data"

  tags = {
    Name        = "pentrail-test-data"
    Project     = "pentrail-test"
    Environment = "demo"
    ManagedBy   = "terraform"
    Owner       = "security-demo"
  }
}

resource "aws_s3_bucket_acl" "data" {
  bucket = aws_s3_bucket.data.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "data" {
  bucket = aws_s3_bucket.data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_logging" "data" {
  bucket        = aws_s3_bucket.data.id
  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "data/"
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket                  = aws_s3_bucket.data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_accessanalyzer_analyzer" "account" {
  analyzer_name = "pentrail-test-analyzer"
  type          = "ACCOUNT"

  tags = {
    Name        = "pentrail-test-analyzer"
    Project     = "pentrail-test"
    Environment = "demo"
    ManagedBy   = "terraform"
    Owner       = "security-demo"
  }
}
