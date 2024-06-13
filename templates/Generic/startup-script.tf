# Runs a script at workspace start/stop or on a cron schedule
# details: https://registry.terraform.io/providers/coder/coder/latest/docs/resources/script
resource "coder_script" "startup_script" {
  agent_id           = coder_agent.main.id
  display_name       = "Startup Script"
  script             = <<-EOF
    #!/bin/bash
    set -e
    # Run programs at workspace startup
    ## fix locales
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    apt install locales -y
    locale-gen
    ## install & configure ssh
    apt update; apt install -y openssh-server
    sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
    mkdir -p /root/.ssh
    echo `vault kv get -field=public -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /root/.ssh/authorized_keys
    echo `vault kv get -field=public -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /root/.ssh/id_ed25519.pub
    echo `vault kv get -field=private -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /root/.ssh/id_ed25519
    chown -R root:root /root
    chmod 700 /root
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/authorized_keys /root/.ssh/id_ed25519 /root/.ssh/id_ed25519.pub
    service ssh start
  EOF
  run_on_start       = true
  start_blocks_login = true
}
