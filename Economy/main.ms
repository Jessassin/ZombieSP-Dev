#binds go in here

bind('player_join',null,null,@event,
	if(!_acc_exists(@player)) {
		_create_account(@player)
	}
)