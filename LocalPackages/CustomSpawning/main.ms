bind(creature_spawn,null,null,@event,
	@file = read('spawnconditions.yml')
	@yml = yml_decode(@file)
	@id = @event['id']
	@type = @event['type']
	@reason = @event['reason']
	#If reason is custom, do not process event
	if(@reason == 'CUSTOM',
		return()
	)
	#checks to ensure the "mobs" key is defined in spawnconditions.yml Tells console if otherwise
	if(array_index_exists(@yml,'mobs'),
		assign(@mobs,@yml['mobs']),
		console('The index "mobs" was not found in spawnconditions.yml')
		cancel()
		return()
	)	
	#checks to ensure that the mob type subkey is defined in spawnconditions.yml Tells console if otherwise
	if(array_index_exists(@mobs,@type),
		assign(@condition,@mobs[@type]),
		console(concat('The specified mob type: ',@type,' is not defined in spawnconditions.yml'))
		cancel()
		return()
	)
	#checks to ensure that the reason subkey is defined under the mobs subkey in spawnconditions.yml Tells console if otherwise
	if(not(array_contains_ic(array_keys(@condition),@reason)),
		console(concat('The spawn reason: ',@reason,' is not defined for: ',@type,' in spawnconditions.yml'))
		cancel()
		return()
	)
	#if specific mob is not enabled, cancel event
	if(not(@condition['enabled']),
		cancel()
		return(),
		#if specific mob is not allowed, cancel
		@allowed = @condition[to_lower(@reason)]
		if(not(@allowed),
			cancel()
			return()
		)
	)
	#If babychance is defined, determine if a baby should be spawned based on percentage
	if(array_index_exists(@condition,'babychance')
		@babychance = @condition['babychance']
		#if the defined value is >= 100 spawn baby and skip check
		if(gte(@babychance,100),
			@spawnbaby = true,
			#get random number between 0 and 100
			@rand = rand(0,100)
			#if the defined variable is >= to the random number generated, spawn a baby - else, don't
			if(gte(@babychance,@rand),
				@spawnbaby = true,
				@spawnbaby = false
			)
		)
	)
	#Same code as above, except for villagers
	if(array_index_exists(@condition,'villagerchance')
		@villagerchance = @condition['villagerchance']
		#if the defined value is >= 100 spawn villager and skip check
		if(gte(@villagerchance,100),
			@spawnvillager = true,
			#get random number between 0 and 100
			@rand = rand(0,100)
			#if the defined variable is >= to the random number generated, spawn a villager - else, don't
			if(gte(@villagerchance,@rand),
				@spawnvillager = true,
				@spawnvillager = false
			)
		)
	)
	#finally, cancel the event, and spawn mob based on our perameters
	cancel()
	#reset head vertical position, because it is incorrectly processed for some reason
	@event['location']['yaw'] = 0
	@type = @event['type']
	if(@spawnbaby,
		@type = concat(@type,':baby')
	)
	if(@spawnvillager,
		@type = concat(@type,':villager')
	)
	spawn_mob(@type,1,@event['location'])
)