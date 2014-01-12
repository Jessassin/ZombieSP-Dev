bind(player_interact, null, array(block: data_values('sign_post'),button: 'right', item: 0), @event,
	@player = @event['player']
	@text = get_sign_text(@event['location'])
	@line1 = @text[0]
	@command = @text[1]
	@line3 = @text[2]
	@line4 = @text[3]
	if(not(equals(@line1,concat(color(a),'[CommandSign]'))),
		break()
	)
	broadcast(concat(@command,' ',@line3,' ',@line4))
	try(run_cmd(concat(@command,' ',@line3,' ',@line4)))
)

bind(sign_changed, null, null, @event,
	@player = @event['player']
	@text = @event['text']
	@location = @event['location']
	if(equals_ic(@text[0],'[CommandSign]'),
		if(not(pisop(@player)),
			cancel()
			tmsg(@player,concat(color(4),'Only OPs may make command signs!'))
			set_sign_text(@location,array(concat(color(4),'[CommandSign]'),@text[1],@text[2],@text[3])),
			cancel()
			tmsg(@player,concat(color(a),'Command sign created!'))
			set_sign_text(@location,array(concat(color(a),'[CommandSign]'),@text[1],@text[2],@text[3]))
		),
		
	)
	#broadcast(@player)
	#broadcast(@text)
)