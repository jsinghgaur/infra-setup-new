#Once you create a IAM ROle and the policies are attached, create the EKS cluster.

resource "aws_eks_cluster" "my-eks-cluster" {
 name = "my-cluster"
 role_arn = aws_iam_role.eks-iam-role.arn

 vpc_config {
  subnet_ids = [var.subnet_id_1, var.subnet_id_2, var.subnet_id_3 ]
 }

 depends_on = [
  aws_iam_role.eks-iam-role,
 ]
}
