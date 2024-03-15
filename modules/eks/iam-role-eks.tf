# Create IAM Role for EKS

resource "aws_iam_role" "eks-iam-role" {
 name = "eks-iam-role"

 path = "/"
  
 #Terraform's "jsonencode" function converts a
 # Terraform expression result to valid JSON syntax.
 assume_role_policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    },
  ]
 })

 tags = {
   tag-key = "tag-value"
 }

}

# Once the role is created, attach these two policies to it:
#  1 . AmazonEKSClusterPolicy
#  2.  AmazonEC2ContainerRegistryReadOnly-EKS
# The two policies allow you to properly access EC2 instances (where the worker nodes run) and EKS.

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role    = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.eks-iam-role.name
}