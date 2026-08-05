resource "aws_s3_bucket" "data" {
  bucket = "pentrail-test-data"
  acl    = "public-read"
}

resource "aws_security_group" "open" {
  name = "pentrail-test-open"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
