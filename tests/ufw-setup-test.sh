#!/usr/bin/env bats

@test "Check if script installs UFW on Debian-based systems" {
  if [[ $(uname -a) == *"Red Hat"* ]]; then
    skip 'Red Hat-based systems'
  fi

  run bash ufw_install.sh
  [[ $(uname -a) == *"Debian"* ]]
  [[ $(ufw status | grep -o "Status: active") == "Status: active" ]]
}

@test "Check if script installs UFW on Red Hat-based systems" {
  if [[ $(uname -a) == *"Debian"* ]]; then
    skip 'Debian-based systems'
  fi

  run bash ufw_install.sh
  [[ $(uname -a) == *"Red Hat"* ]]
  [[ $(ufw status | grep -o "Status: active") == "Status: active" ]]
}

@test "Check if script allows incoming traffic on specified ports" {
  run bash ufw_install.sh
  open_ports="80|443|22"
  [[ $(ufw status | grep -oP "($open_ports)[[:space:]]+ALLOW") ]]
}
