fx_version 'cerulean'
game 'gta5'

author 'Fast Shop'
description 'Job Center NPC Script'
version '1.0.0'
lua54 'yes'
shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js'
}

dependencies {
    'es_extended',
    'ox_lib'
}

escrow_ignore {
    'ui/index.html',
    'ui/style.html',
    'ui/script.html',
    'ui/config.lua',
}
