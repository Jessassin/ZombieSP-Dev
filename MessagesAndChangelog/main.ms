#bind on join event
bind('player_join', null, null, @event,
	#get on join message from YAML file
	@file = read('config.yml')
	@yml = yml_decode(@file)
	#send welcome message
	tmsg(@event['player'], @yml['motd'])
)