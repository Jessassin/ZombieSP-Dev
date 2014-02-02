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
		if(@all,
			@ids = _get_all_ids('high')
			foreach(@ids,@id,
				_respawn_box_id(@id)
			)
		),
		@id = _get_rand_id('high')
		_respawn_box_id(@id)
	)
	if(@quality == 'low',
		if(@all,
			@ids = _get_all_ids('low')
			foreach(@ids,@id,
				_respawn_box_id(@id)
			)
		),
		@id = _get_rand_id('low')
		_respawn_box_id(@id)
	)
)

proc(_respawn_box_id,@id,
	@query = query('testserver', 'SELECT x,y,z,quality FROM lootboxes WHERE id=?', @id)
	@query = @query[0]
	@loc = array(@query[x],@query[y],@query[z],'world')
	@quality = @query[quality]
	if(@quality = 1,
		@id = '33:7',
		@id = '33:6'
	)
	set_block_at(@loc,@id)
)

proc(_format_location,@string,
	@loc = reg_split(',',@string)
	array_set(@loc,3,'world')
	return(@loc)
)

proc(_modify_lootbox,@location,@action,@quality,
	@x = @location[0]
	@y = @location[1]
	@z = @location[2]
	if(equals_ic(@quality,'low'),
		@quality = 0,
		@quality = 1
	)
	@query = query('testserver', 'SELECT id FROM lootboxes WHERE x=? AND y=? AND z=?', @x,@y,@z)
	if(length(@query) == 0,
		@exists = false,
		@exists = true
		@id = @query[0][ID]
	)
	if(equals_ic(@action,'create'),
		if(@exists,
			query('testserver', 'UPDATE lootboxes SET x=?,y=?,z=?,quality=?,enabled=1 WHERE ID=?', @x,@y,@z,@quality,@id)
			, #if not exists
			query('testserver', 'INSERT INTO lootboxes (x,y,z,quality,enabled) VALUES (?,?,?,?,1)', @x,@y,@z,@quality)
		), #else - action will be remove
		if(@exists,
			query('testserver', 'UPDATE lootboxes SET enabled=0 WHERE x=? AND y=? AND z=?', @x,@y,@z)
			return() #if it is not in table, nothing to remove
		)
	)
)

proc(_lootbox_info,@loc,
	@x = @loc[0]
	@y = @loc[1]
	@z = @loc[2]
	@query = query('testserver', 'SELECT * FROM lootboxes WHERE x=? AND y=? AND z=?', @x,@y,@z)
	@query = @query[0]
	@id = @query['ID']
	@x = @query['x']
	@y = @query['y']
	@z = @query['z']
	if(@query['quality'],
		@quality = 'high',
		@quality = 'low'
	)
	if(@query['enabled'],
		@enabled = 'true',
		@enabled = 'false'
	)
	@return = concat('ID: ',@id,' X: ',@x,' Y: ',@y,' Z: ',@z,' Quality: ',@quality,' Enabled: ',@enabled)
	return(@return)
)

proc(_get_all_ids,@quality,
	if(equals_ic(@quality,'high'),
		@quality = 1,
		@quality = 0
	)
	@query = query('testserver', 'SELECT id FROM lootboxes WHERE quality=? AND enabled=1', @quality)
	@ids = array()
	foreach(@query,@item,
		array_push(@ids,@item['ID'])
	)
	return(@ids)
)

proc(_get_rand_id,@quality,
	if(equals_ic(@quality,'high'),
		@quality = 1,
		@quality = 0
	)
	#select all IDs that match the quality, and are enabled
	@query = query('testserver', 'SELECT id FROM lootboxes WHERE quality=? AND enabled=1', @quality)
	#select random ID and assign value to @return, then return @return
	@index = array_rand(@query)
	@return = @query[@index[0]]['ID']
	return(@return)
)