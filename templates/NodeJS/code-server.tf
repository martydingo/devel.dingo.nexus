# Adds code-server
# See all available modules at https://registry.coder.com
module "code-server" {
  source   = "registry.coder.com/modules/code-server/coder"
  version  = "1.0.2"
  agent_id = coder_agent.main.id
}
