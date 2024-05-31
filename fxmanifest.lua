fx_version "cerulean"
game "gta5"
lua54 "yes"

author 'Cadburry (ByteCode Studios)'

shared_scripts {
    '@ox_lib/init.lua',
    'config/config.lua'
}

client_scripts {
    'config/config_client.lua',
    'scripts/client.lua',
}

server_scripts {
    'config/config_server.lua',
    'scripts/server.lua',
}

ui_page "index.html"

files {
    "filter.jpeg",
    "index.html"
}

dependencies {
    '/onesync',
    'ox_lib',
}