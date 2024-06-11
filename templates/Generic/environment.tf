resource "coder_env" "welcome_message" {
  agent_id = coder_agent.main.id
  name     = "WELCOME_MESSAGE"
  value    = "Welcome to your Coder workspace!"
}
