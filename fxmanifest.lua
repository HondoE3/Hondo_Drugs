fx_version 'cerulean'
game 'gta5'

description 'Weed, Skunk og Svampe System lavet til Valtstic med ox_lib'
author 'Hondo'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    '@ox_lib/init.lua',
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

dependencies {
    'ox_lib',
    'oxmysql',
 -- 'qbx_core', -- Uncomment dette og comment qb-core hvis du bruger qbx
    'qb-core',
 -- 'qb-inventory', -- Uncomment dette og comment ox_inventory hvis du bruger ox
    'ox_target'
 -- 'ox_inventory' -- Uncomment dette og comment qb-inventory hvis du bruger ox
}