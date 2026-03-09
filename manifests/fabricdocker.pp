# Ensure docker is installed
include docker

# Clone the FabricDockerServer repository
vcsrepo { '/srv/fabricdocker':
  ensure   => present,
  provider => git,
  source   => 'https://github.com/Havicish/FabricDockerServer.git',
}

# Data directory for persistent world storage
file { '/srv/fabricdocker-data':
  ensure => directory,
  owner  => 0,
  group  => 0,
}

# Management script to check for updates and manage the container
file { '/srv/fabricdocker-manager.sh':
  ensure  => file,
  mode    => '0755',
  owner   => 0,
  group   => 0,
  content => '#!/bin/bash
REPO_DIR="/srv/fabricdocker"
CONTAINER_NAME="minecraft"
COMMIT_FILE="/srv/fabricdocker/.last_commit"

cd "$REPO_DIR" || exit 1

# Get current commit before fetch
OLD_COMMIT=$(cat "$COMMIT_FILE" 2>/dev/null || echo "none")

# Fetch updates and reset to remote (handles local changes from puppet)
git fetch origin
BRANCH=$(git remote show origin | grep "HEAD branch" | sed "s/.*: //")
git reset --hard "origin/$BRANCH"

# Get new commit
NEW_COMMIT=$(git rev-parse HEAD)

# Check if container is running
CONTAINER_RUNNING=$(docker ps -q -f name="^${CONTAINER_NAME}$")

# Start or restart container as needed
if [ "$OLD_COMMIT" != "$NEW_COMMIT" ]; then
  echo "$(date): Repository updated from $OLD_COMMIT to $NEW_COMMIT"
  # Stop existing container if running
  if [ -n "$CONTAINER_RUNNING" ]; then
    docker stop "$CONTAINER_NAME" 2>/dev/null
    docker rm "$CONTAINER_NAME" 2>/dev/null
  fi
  # Start container with new code
  chmod +x "$REPO_DIR/run"
  cd "$REPO_DIR" && ./run
  echo "$NEW_COMMIT" > "$COMMIT_FILE"
elif [ -z "$CONTAINER_RUNNING" ]; then
  echo "$(date): Container not running, starting..."
  # Remove stopped container if exists
  docker rm "$CONTAINER_NAME" 2>/dev/null
  chmod +x "$REPO_DIR/run"
  cd "$REPO_DIR" && ./run
  echo "$NEW_COMMIT" > "$COMMIT_FILE"
fi
',
  require => Vcsrepo['/srv/fabricdocker'],
}

# Cron job to check for updates every minute
cron { 'fabricdocker-update':
  ensure  => present,
  command => '/srv/fabricdocker-manager.sh >> /var/log/fabricdocker.log 2>&1',
  user    => root,
  minute  => '*',
  require => File['/srv/fabricdocker-manager.sh'],
}

# Initial run to start the container
exec { 'fabricdocker-initial-start':
  command     => '/srv/fabricdocker-manager.sh',
  refreshonly => true,
  subscribe   => Vcsrepo['/srv/fabricdocker'],
  require     => [
    File['/srv/fabricdocker-manager.sh'],
    Vcsrepo['/srv/fabricdocker'],
    Class['docker'],
  ],
}

# Ensure minecraft container is always running
exec { 'ensure-minecraft-running':
  command => '/bin/bash -c "if ! /usr/bin/docker ps | grep -q minecraft; then cd /srv/fabricdocker && ./run; fi"',
  unless  => '/usr/bin/docker ps | grep -q minecraft',
  path    => ['/usr/bin', '/bin'],
  require => [
    Vcsrepo['/srv/fabricdocker'],
    File['/srv/fabricdocker-manager.sh'],
  ],
}
