module "nodejs" {
  source   = "registry.coder.com/modules/nodejs/coder"
  version  = "1.0.10"
  agent_id = coder_agent.main.id
}
