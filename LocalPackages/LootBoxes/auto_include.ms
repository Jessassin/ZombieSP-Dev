proc(_respawn_tick_start,
	@settings = yml_decode(read('config.yml'))['settings']
	@lowinterval = @settings['low']['respawn-interval']
	@highinterval = @settings['high']['respawn-interval']
	@highall = @settings['high']['respawn-all']
	@lowall = @settings['low']['respawn-all']
	set_interval(@highinterval,
		closure(_respawn_boxes('high',@highall))
	)
	set_interval(@lowinterval,
		closure(_respawn_boxes('low',@lowall))
	)
)

proc(_respawn_boxes,@quality,@all,
	if(@quality == 'high',
		@high = yml_decode(read('locations.yml'))['high']
		if(@all,
			foreach(@high,@location,
				@loc = _format_location(@location)
				set_block_at(@loc,1)
			),
			@rand = rand(0,length(@high))
			@loc = _format_location(array_get(@high,@rand))
			set_block_at(@loc,'33:7')
		)
	)
	if(@quality == 'low',
		@low = yml_decode(read('locations.yml'))['low']
		if(@all,
			foreach(@low,@location,
				@loc = _format_location(@location)
				set_block_at(@loc,1)
			),
			@rand = rand(0,length(@low))
			@loc = _format_location(array_get(@low,@rand))
			set_block_at(@loc,'33:6')
		)
	)
)


proc(_format_location,@string,
	@loc = reg_split(',',@string)
	array_set(@loc,3,'world')
	return(@loc)
)