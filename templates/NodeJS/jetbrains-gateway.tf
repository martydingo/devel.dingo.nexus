module "jetbrains-gateway" {
  source         = "registry.coder.com/modules/jetbrains-gateway/coder"
  version        = "1.0.13"
  agent_id       = coder_agent.main.id
  agent_name     = "jetbrains-gateway"
  folder         = "/home/coder"
  latest         = true
  channel        = "eap"
  jetbrains_ides = ["WS"]
  default        = "WS"
}
