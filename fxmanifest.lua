fx_version 'bodacious'
game 'gta5'

name 'FiveM Typescript Boilerplate'
description 'A boilerplate for using Typescript in FiveM'
author 'Remco Troost (d0p3t)'
url 'https://github.com/d0p3t/fivem-ts-boilerplate'

files {"dependency/**", "images/**", "fonts/**", "html/**", "dist/view/**"}

ui_page "html/index.html"

client_script {'dist/client/*.client.js'}
