#binds go in here

bind('player_join',null,null,@event,
	if(!_acc_exists(@event['player'])) {
		_create_account(@event['player'])
	}
)