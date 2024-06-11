# Runs a script at workspace start/stop or on a cron schedule
# details: https://registry.terraform.io/providers/coder/coder/latest/docs/resources/script
resource "coder_script" "startup_script" {
  agent_id           = coder_agent.main.id
  display_name       = "Startup Script"
  script             = <<-EOF
    #!/bin/sh
    set -e
    # Run programs at workspace startup
    ## install & configure ssh
    apt update; apt install -y openssh-server
    mkdir -p /root/.ssh
    echo `vault kv get -field=public -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    service ssh start
  EOF
  run_on_start       = true
  start_blocks_login = true
}
