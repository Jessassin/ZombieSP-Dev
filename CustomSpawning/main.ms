bind('creature_spawn',null,null,@event,
	@config = yml_decode(read('spawnconditions.yml'))

	if(@event['reason'] == 'CUSTOM',
		return()
	)

	if(array_index_exists(@config,'mobs'),
		assign(@mobs,@config['mobs']),
		console('The index "mobs" was not found in spawnconditions.yml')
		return()
	)

	if(array_index_exists(@mobs,@event['type']),
		assign(@condition,@mobs[@event['type']]),
		console(concat('The specified mob type: ',@event['type'],' is not defined in spawnconditions.yml'))
		return()
	)
	if(not(array_contains_ic(array_keys(@condition),@event['reason'])),
		console(concat('The spawn reason: ',@event['reason'],' is not defined for: ',@event['type'],' in spawnconditions.yml'))
		return()
	)

	#if specific mob is not enabled, cancel event
	if(not(@condition['enabled']),
		cancel()
		return(),
		#if specific mob is not allowed, cancel
		@allowed = @condition[to_lower(@event['reason'])]
		if(not(@allowed),
			cancel()
			return()
		)
	)

)