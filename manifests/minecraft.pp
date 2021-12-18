docker::run { 'minecraft':
  image                 => 'itzg/minecraft-server',
  privileged            => false,
  env                   => [
    'EULA=true', 
    'ENABLE_COMMAND_BLOCK=true', 
    'GENERATE_STRUCTURES=true', 
    'MODE=creative',
    'OPS=enty6Chick6',
    'ENABLE_QUERY=true',
    'ALLOW_NETHER=true',
    'ENABLE_COMMAND_BLOCK=true',
    'SPAWN_ANIMALS=true',
    'SPAWN_MONSTERS=true',
    'SPAWN_NPCS=true',
    'WHITELIST=enty6Chick6,thebraveerror'
  ],
  ports                 => ['25575:25575', '25565:25565'],
  health_check_interval => 30,
  volumes               => [
    '/home/ccaum/minecraft-data:/data'
  ],
  require               => Class['docker'],
}
