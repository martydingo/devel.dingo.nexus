# Runs a script at workspace start/stop or on a cron schedule
# details: https://registry.terraform.io/providers/coder/coder/latest/docs/resources/script
resource "coder_script" "startup_script" {
  agent_id           = coder_agent.main.id
  display_name       = "Startup Script"
  script             = <<-EOF
    #!/bin/bash
    set -e
    # sleep for 10 seconds to allow module installations
    sleep 10
    # Run programs at workspace startup
    sudo /usr/bin/bash -c '
      ## install & configure ssh
      apt update; sudo apt install -y openssh-server
      sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
      usermod --login marty coder
      mv /home/coder/* /home/marty/
      groupmod --new-name marty coder
      usermod -p `vault kv get -field=yescrypt kv/users/${lower(data.coder_workspace_owner.me.name)}/password` marty
      mkdir -p /home/${lower(data.coder_workspace_owner.me.name)}/.ssh
      echo `vault kv get -field=public -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /home/${lower(data.coder_workspace_owner.me.name)}/.ssh/authorized_keys
      echo `vault kv get -field=public -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /home/${lower(data.coder_workspace_owner.me.name)}/.ssh/id_ed25519.pub
      echo `vault kv get -field=private -mount=kv users/${lower(data.coder_workspace_owner.me.name)}/ssh-key` > /home/${lower(data.coder_workspace_owner.me.name)}/.ssh/id_ed25519
      chown -R ${lower(data.coder_workspace_owner.me.name)}:${lower(data.coder_workspace_owner.me.name)} /home/${lower(data.coder_workspace_owner.me.name)}
      chmod 700 /home/${lower(data.coder_workspace_owner.me.name)}/.ssh
      chmod 600 /home/${lower(data.coder_workspace_owner.me.name)}/.ssh/authorized_keys /home/${lower(data.coder_workspace_owner.me.name)}/.ssh/id_ed25519 /home/${lower(data.coder_workspace_owner.me.name)}/.ssh/id_ed25519.pub
      service ssh start
      ## fix locales
      echo "LC_ALL=en_US.UTF-8" >> /etc/environment
      echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
      echo "LANG=en_US.UTF-8" > /etc/locale.conf
      apt install locales -y
      ## install pnpm
      curl -fsSL https://get.pnpm.io/install.sh | sh -
    '
  EOF
  run_on_start       = true
  start_blocks_login = true
}
