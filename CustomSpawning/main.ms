bind('creature_spawn',null,null,@event,
	@config = yml_decode(read('spawnconditions.yml'))

	if(@event['reason'] == 'CUSTOM') {
		return()
	}

	if(array_index_exists(@config,'mobs')) {
		assign(@mobs,@config['mobs'])
	} else {
		console('The index "mobs" was not found in spawnconditions.yml')
		return()
	}

	if(array_index_exists(@mobs,@event['type'])) {
		assign(@condition,@mobs[@event['type']])
	} else {
		console('The specified mob type: '.@event['type'].' is not defined in spawnconditions.yml')
		return()
	}

	if(not(array_contains_ic(array_keys(@condition),@event['reason']))) {
		console('The spawn reason: '.@event['reason'].' is not defined for: '.@event['type'].' in spawnconditions.yml')
		return()
	}

	if(! @config['mobs'][@event['type']]['enabled']) {
		cancel()
		return()
	} else {
		if(@config['mobs'][@event['type']][@event['reason']]) {
			console('Cancelling spawn of: '.@event['type'].' because the spawn reason '.@event['reason'].' is not enabled for this mob.')
			cancel()
			return()
		}
	}
)