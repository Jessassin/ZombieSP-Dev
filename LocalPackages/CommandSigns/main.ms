#binds to player interact, filters to interactions with "sign post" block only
bind(player_interact, null, array(block: data_values('sign_post'),button: 'right', item: 0), @event,
	#define ivars
	@line1 = get_sign_text(@event['location'])[0]
	@command = get_sign_text(@event['location'])[1]
	@line3 = get_sign_text(@event['location'])[2]
	@line4 = get_sign_text(@event['location'])[3]
	#If line 1 is not a valid commandsign, break. !Note color!
	if(not(equals(@line1,concat(color(a),'[CommandSign]'))),
		break()
	)
	#else try running command starting on line 2
	try(run_cmd(concat(@command,' ',@line3,' ',@line4)))
)

#bind sign changed event
bind(sign_changed, null, null, @event,
	#pull text into ivar
	@text = @event['text']
	#if line 1 is command sign text,  cancel event, and then run op check 
	if(equals_ic(@text[0],'[CommandSign]'),
		cancel()
		#if player is op, create sign with valid color
		if(pisop(@player),
			tmsg(@event['player'],concat(color(a),'Command sign created!'))
			set_sign_text(@event['location'],array(concat(color(a),'[CommandSign]'),@text[1],@text[2],@text[3])),
			#else create sign with invalid color
			tmsg(@event['player'],concat(color(4),'Only OPs may make command signs!'))
			set_sign_text(@event['location'],array(concat(color(4),'[CommandSign]'),@text[1],@text[2],@text[3]))
		),
	)
)