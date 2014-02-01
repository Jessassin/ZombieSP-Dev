#binds go in here

bind(player_join,null,null,@event,
	#broadcast(@event['player'])
	_create_account(@event['player'])
)