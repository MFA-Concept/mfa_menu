fx_version 'bodacious'
game 'gta5'

name 'MFA Menu'
description 'A simple menu write in HTML and ts for FiveM'
author 'MFA Concept'
url 'https://github.com/MFA-Concept/mfa-menu'

files {
    "dependency/*.lua",
    "dependency/**/*.lua",
    "dependency/*.js",
    "dependency/**/*.js",
    "images/**", "fonts/**", 
    "html/**", 
    "dist/view/**"
}

ui_page "html/index.html"

client_scripts {
    'dist/client/*.client.js',
    'dependency/menumanager_default.lua'
}
