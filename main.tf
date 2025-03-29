# IAM Role for EC2 to access DynamoDB
resource "aws_iam_role" "ec2_dynamodb_role" {
  name = "rudy-EC2-DynamoDBRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM Policy for DynamoDB access
resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "DynamoDBAccessPolicy"
  description = "Policy to allow EC2 access to DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_dynamodb_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

# Create Instance Profile
resource "aws_iam_instance_profile" "rudy_ec2_instance_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_dynamodb_role.name
}

# Security Group for EC2
resource "aws_security_group" "ec2_security_group" {
  name        = "Rudy_EC2SecurityGroup"
  description = "Allow SSH and HTTP access"
  vpc_id      = "vpc-0c4b466716812ba8c" # Replace with your VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere, adjust as needed
  }
}
  # ingress {

