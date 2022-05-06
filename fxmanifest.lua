game "gta5"
fx_version 'cerulean'
lua54 'yes'
version '1.3'
author 'maku#5434'
description 'Lib for all codely scripts'

client_scripts {
	'client/framework/cl_frameworkloader.lua',
	'client/framework/types/*.lua',
	'client/framework/cl_framework.lua',

	'client/cl_main.lua',

	'client/cl_load.lua'
}

shared_scripts {
	'configs/sh_config.lua',

	'shared/sh_commons.lua',
	'shared/sh_cfxcommons.lua',
	'shared/sh_logging.lua',
	'shared/loader/sh_loader.lua'
}

server_scripts {
	'configs/sv_config.lua',

	'server/sv_discord.lua',
	'server/sv_items.lua',

	'server/rest_storage/sv_storage.lua',

	'@mysql-async/lib/MySQL.lua',
	'server/database/sv_databaseloader.lua',
	'server/database/types/*.lua',
	'server/database/sv_database.lua',

	'server/framework/sv_frameworkloader.lua',
	'server/framework/types/*.lua',
	'server/framework/sv_framework.lua',

	'server/sv_load.lua'
}

depencies {
	'cron'
}

exports {
	'GetFrameworkObject',
	'InitLogger',
	'GetCoreLoggerObject',
	'GetLoaderObject',
}

server_exports {
	'SendWebhook',
	'InitLogger',
	'GetCoreLoggerObject',
	'GetLoaderObject',
	'GetFrameworkObject',
	'GetDatabaseObject',
        'InitializeStorage'
}

dependency '/server:4700' -- You must have server artifact at least 4700
