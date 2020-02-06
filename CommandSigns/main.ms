#binds to player interact, filters to interactions with "sign post" block only
bind('player_interact', null, array(button: 'right', item: 0, hand: 'main_hand'), @event) {
	@block = @event['block']
	#it is not a sign, stop processing event
	if(!string_ends_with(@event['block'],'SIGN')) {
		return()
	}
	#define ivars
	@line1 = get_sign_text(@event['location'])[0]
	@line2 = get_sign_text(@event['location'])[1]
	@line3 = get_sign_text(@event['location'])[2]
	@line4 = get_sign_text(@event['location'])[3]
	#If line 1 is not a valid commandsign, break. !Note color!
	if(not(equals(@line1,color('a').'[CommandSign]'))) {
		return()
	}
	#else try running command starting on line 2
	try(run_cmd(@line2.' '.@line3.' '.@line4))
}

#bind sign changed event
bind('sign_changed', null, null, @event) {
	@text = @event['text']
	#if line 1 is command sign text,  cancel event, and then run op check 
	if(equals_ic(@text[0],'[CommandSign]')) {
		cancel()
		#if player is op, create sign with valid color
		if(pisop(@event['player'])) {
			tmsg(@event['player'],concat(color('a'),'Command sign created!'))
			set_sign_text(@event['location'],array(color('a').'[CommandSign]',@text[1],@text[2],@text[3]))
		} else {
			#else create sign with invalid color
			tmsg(@event['player'],concat(color(4),'Only OPs may make command signs!'))
			set_sign_text(@event['location'],array(color(4).'[CommandSign]',@text[1],@text[2],@text[3]))
		}
	}
}