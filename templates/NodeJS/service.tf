resource "kubernetes_service" "nodejs-service" {
  metadata {
    name      = "workspace-${lower(data.coder_workspace_owner.me.name)}-${lower(data.coder_workspace.me.name)}"
    namespace = "devel-dingo-nexus"
    annotations = {
      "io.cilium/lb-ipam-ips" = data.coder_parameter.load_balancer_ip.value
    }
  }
  spec {
    type             = "LoadBalancer"
    ip_family_policy = "PreferDualStack"
    ip_families      = ["IPv4", "IPv6"]
    selector = {
      "app.kubernetes.io/instance" = "coder-workspace-${lower(data.coder_workspace_owner.me.name)}-${lower(data.coder_workspace.me.name)}"
    }
    port {
      port        = 22
      target_port = 22
      name        = "ssh"
    }
    port {
      port        = 3000
      target_port = 3000
      name        = "node"
    }
  }
}
