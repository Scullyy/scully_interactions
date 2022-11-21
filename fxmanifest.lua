--- https://discord.gg/scully ---
fx_version 'adamant'

game 'gta5'
version '1.0.0'

dependencies {
    '/server:5848',
    '/onesync',
    'ox_lib'
}

shared_scripts {
    '@ox_lib/init.lua'
}

client_scripts {
    'config.lua',
    'client/*.lua'
}

lua54 'yes'

