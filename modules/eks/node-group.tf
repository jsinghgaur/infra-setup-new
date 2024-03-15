# Create Worker Node for EKS
resource "aws_eks_node_group" "worker-node-group" {
  cluster_name       = aws_eks_cluster.my-eks-cluster.name
  node_group_name    = "my-workernode-group"
  node_role_arn      = aws_iam_role.eks-workernodes.arn
  subnet_ids         = [var.subnet_id_1, var.subnet_id_2, var.subnet_id_3]
  instance_types     = [var.instance_type]

 
  scaling_config {
   desired_size = var.desired_size
   max_size     = var.max_size
   min_size     = var.min_size
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
   aws_iam_role_policy_attachment.EC2InstanceProfileForImageBuilderECRContainerBuilds,
  ]
 }
