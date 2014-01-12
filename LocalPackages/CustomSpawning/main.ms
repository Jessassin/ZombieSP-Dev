bind(creature_spawn,null,null,@event,
	#broadcast(@event)
	@type = @event['type']
	@file = read('spawnconditions.yml')
	@yml = yml_decode(@file)
	if(array_index_exists(@yml,@type),
		@index = @yml[@type]
		if(not(@index['enabled'] == 'true'),
			cancel()
		)
	)
)