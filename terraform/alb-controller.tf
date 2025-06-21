resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.13.0"

  values = [
    yamlencode({
      clusterName = module.eks.cluster_name
      region      = local.aws_region
      vpcId       = module.vpc.vpc_id

      serviceAccount = {
        create = false
        name   = "aws-load-balancer-controller"
      }
    })
  ]

  depends_on = [
    module.alb_controller
    module.eks
  ]
}
