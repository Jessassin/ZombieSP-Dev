#binds go in here

bind('player_join',null,null,@event,
	_create_account(@event['player'])
)