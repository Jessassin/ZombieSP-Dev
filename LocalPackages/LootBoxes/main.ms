bind(player_interact,null,array(block: '33:6','33:7'),@event,
	@file = read('config.yml')
	@yml = yml_decode(@file)
	set_block_at(@event['location'],0)
	make_effect(@event['location'],'STEP_SOUND:5',8)
	set_timeout(400,closure(break_block(@event['location'])))
	@low = @yml['drops']['low']
	@high = @yml['drops']['high']
	if(@event['block'] == '33:6',
		for(assign(@i,0), @i < length(@low), @i++,
			@item = array_keys(@low)[@i]
			@chance = @low[@item]['chance']
			#if the drop chance is less than 100%, spawn on percentage chance
			if(@chance < 100,
				@rand = rand(0,100)
				if(@rand <= @chance,
					drop_item(@event['location'],array(type: @item),true)
				),
				#else, spawn item
				drop_item(@event['location'],array(type: @item),true)
			)
		)
	)
	if(@event['block'] == '33:7',
		for(assign(@i,0), @i < length(@high), @i++,
			@item = array_keys(@high)[@i]
			@chance = @high[@item]['chance']
			#if the drop chance is less than 100%, spawn on percentage chance
			if(@chance < 100,
				@rand = rand(0,100)
				if(@rand <= @chance,
					drop_item(@event['location'],array(type: @item),true)
				),
				#else, spawn item
				drop_item(@event['location'],array(type: @item),true)
			)
		)
	)
)