module "vault" {
  source               = "registry.coder.com/modules/vault-github/coder"
  version              = "1.0.7"
  agent_id             = coder_agent.main.id
  vault_addr           = "https://vault.dingo.nexus"
  coder_github_auth_id = "devel-dingo-nexus"
}
