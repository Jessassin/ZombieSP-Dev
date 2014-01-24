#bind on join event
bind(player_join, null, null, @event,
	#get player info from YAML file
	try(@file = read(concat("players/", @event['player'], ".yml")), @ex,
		// write blank file
		break()
	)
	@yml = yml_decode(@file)
	#send welcome message
	tmsg(concat("You have a balance of: ", @yml['balance']))
)