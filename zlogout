sudo -k

if [ -z "$SSH_CLIENT" ]; then
  # Clean up /tmp/gpg-* after exiting window manager
  killall gpg-agent
  test -n "$GPG_AGENT_INFO" && rm -rf $(dirname $GPG_AGENT_INFO)
  unset GPG_AGENT_INFO
fi

clear
