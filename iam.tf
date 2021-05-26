# ECS EC2 Role
resource "aws_iam_role" "ecs-ec2-role" {
  name = "ecs-ec2-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

# ECS EC2 Role Policy
resource "aws_iam_role_policy" "ecs-ec2-role-policy" {
  name = "ecs-ec2-role-policy"
  role = aws_iam_role.ecs-ec2-role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "ecs:CreateCluster",
              "ecs:DeregisterContainerInstance",
              "ecs:DiscoverPollEndpoint",
              "ecs:Poll",
              "ecs:RegisterContainerInstance",
              "ecs:StartTelemetrySession",
              "ecs:Submit*",
              "ecs:StartTask",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF

}

# ECS EC2 Role Profile
resource "aws_iam_instance_profile" "ecs-ec2-role-profile" {
  name = "ecs-ec2-role-profile"
  role = aws_iam_role.ecs-ec2-role.name
}

# ECS Service Role
resource "aws_iam_role" "ecs-service-role" {
  name = "ecs-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

# S3 Object Write Role
resource "aws_iam_role_policy" "s3-object-write-policy" {
  name = "s3-object-write-policy"
  role = aws_iam_role.ecs-service-role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::nginx-container-bucket/*"
    }
  ]
}
EOF

}

# ECS Service Role Policy Attachment
resource "aws_iam_policy_attachment" "ecs-service-policy-attachment" {
  name = "ecs-service-policy-attachment"
  roles = [
    aws_iam_role.ecs-service-role.name
  ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
