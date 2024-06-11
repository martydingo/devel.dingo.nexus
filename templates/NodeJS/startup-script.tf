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
    apt update; apt install -y openssh-server
    sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
    userdel coder; useradd -m marty -G sudo -p `vault kv get -field=yescrypt kv/users/${lower(data.coder_workspace_owner.me.name)}/password` -s /bin/bash
    mkdir -p /home/${lower(data.coder_workspace_owner.me.name)}/.ssh
    echo `vault kv get -field=public -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /home/marty/.ssh/authorized_keys
    service ssh start
  EOF
  run_on_start       = true
  start_blocks_login = true
}
