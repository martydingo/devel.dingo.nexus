# Runs a script at workspace start/stop or on a cron schedule
# details: https://registry.terraform.io/providers/coder/coder/latest/docs/resources/script
resource "coder_script" "startup_script" {
  agent_id           = coder_agent.main.id
  display_name       = "Startup Script"
  script             = <<-EOF
    #!/bin/bash
    set -e
    # Run programs at workspace startup
    ## install & configure ssh
    sudo apt update; sudo apt install -y openssh-server
    sudo sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
    mkdir -p /home/coder/.ssh
    echo `vault kv get -field=public -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /home/coder/.ssh/authorized_keys
    chmod -R 600 /home/coder/
    sudo service ssh start
  EOF
  run_on_start       = true
  start_blocks_login = true
}
