module "git-config" {
  source   = "registry.coder.com/modules/git-config/coder"
  version  = "1.0.15"
  agent_id = coder_agent.main.id
}

module "git-clone" {
  source   = "registry.coder.com/modules/git-clone/coder"
  version  = "1.0.12"
  agent_id = coder_agent.main.id
  url      = data.coder_parameter.github_repository.value
}
