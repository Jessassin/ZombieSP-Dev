#binds go in here

bind('player_interact', null, null, @event,
	@block = @event['block']
	#it is not a sign, stop processing event
	if(not(or(equals_ic(data_name(@block),'Sign Post'),equals_ic(data_name(@block),'Wall Sign'))),
		return(),
	)
	@text = get_sign_text(@event['location'])
	@player = @event['player']
	if(equals(@text[0],colorize('&a[Buy]')),
		@qty = @text[1]
		@item = @text[2]
		@cost = replace(@text[3],'$','')
		if(_acc_balance(@player) >= @cost,
			_acc_subtract(@player,@cost * @qty)
			pgive_item(@player,data_values(@item),@qty)
			tmsg(@player,colorize(concat('Bought ',@qty,' of ',@item,' for $',@cost * @qty)))
		)
	)
	if(equals(@text[0],colorize('&a[Sell]')),
		@qty = @text[1]
		@item = @text[2]
		@cost = replace(@text[3],'$','')
		@taken = ptake_item(@player,data_values(@item),@qty)
		if(@taken <= 0,
			tmsg(@player,colorize(concat('&4You do not have any of &f',@item)))
			return()
		)
		if(@taken < @qty,
			_acc_add(@player,@cost * @taken)
			tmsg(@player,colorize(concat('Sold ',@taken,' of ',@item,' for $',@cost * @taken))),
			_acc_add(@player,@cost * @qty)
			tmsg(@player,colorize(concat('Sold ',@qty,' of ',@item,' for $',@cost * @qty)))
		)
	)
)

bind('sign_changed', null, null, @event,
	#pull text into ivar
	@text = @event['text']
	#if line 1 is command sign text,  cancel event, and then run op check 
	if(equals_ic(@text[0],'[buy]'),
		cancel()
		#if player is not op, create invalid sign and return
		if(not(pisop(@player)),
			tmsg(@event['player'],concat(color(4),'Only OPs may make buy signs!'))
			set_sign_text(@event['location'],array(concat(color(4),'[Buy]'),@text[1],@text[2],@text[3]))
			return()
		)
		@valid = true
		#If line 1 is not numeric, set line2 to invalid
		if(not(is_numeric(@text[1])),
			@line2 = concat('&4',@text[1])
			@valid = false,
			@line2 = @text[1]
		)
			#if line 2 is numeric, convert it to data_name otherwise do the reverse
		if(is_numeric(@text[2]),
			@line3 = to_lower(data_name(@text[2])),
			@line3 = to_lower(data_values(@text[2]))
		)
		#If line 3 ends up being null, set line3 to invalid (will be null if item id or name is not valid)
		if(equals(@line3,'null'),
			@line3 = concat('&4',@text[2])
			@valid = false
		)
		@line4 = replace(@text[3],'$','')
		@line4 = concat('$',@line4)
		if(@valid,
			tmsg(@event['player'],concat(color('a'),'Buy sign created!'))
			@line1 = '&a[Buy]',
			tmsg(@event['player'],concat(color(4),'Buy sign invalid!'))
			@line1 = '&4[Buy]'
		)
		set_sign_text(@event['location'],array(colorize(@line1),colorize(@line2),colorize(@line3),colorize(@line4)))
	)
	if(equals_ic(@text[0],'[sell]'),
		cancel()
		#if player is not op, create invalid sign and return
		if(not(pisop(@player)),
			tmsg(@event['player'],concat(color(4),'Only OPs may make sell signs!'))
			set_sign_text(@event['location'],array(concat(color(4),'[Sell]'),@text[1],@text[2],@text[3]))
			return()
		)
		@valid = true
		#If line 1 is not numeric, set line2 to invalid
		if(not(is_numeric(@text[1])),
			@line2 = concat('&4',@text[1])
			@valid = false,
			@line2 = @text[1]
		)
			#if line 2 is numeric, convert it to data_name otherwise do the reverse
		if(is_numeric(@text[2]),
			@line3 = to_lower(data_name(@text[2])),
			@line3 = to_lower(data_values(@text[2]))
		)
		#If line 3 ends up being null, set line3 to invalid (will be null if item id or name is not valid)
		if(equals(@line3,'null'),
			@line3 = concat('&4',@text[2])
			@valid = false
		)
		@line4 = replace(@text[3],'$','')
		@line4 = concat('$',@line4)
		if(@valid,
			tmsg(@event['player'],concat(color('a'),'Sell sign created!'))
			@line1 = '&a[Sell]',
			tmsg(@event['player'],concat(color(4),'Sell sign invalid!'))
			@line1 = '&4[Sell]'
		)
		set_sign_text(@event['location'],array(colorize(@line1),colorize(@line2),colorize(@line3),colorize(@line4)))
	)
)