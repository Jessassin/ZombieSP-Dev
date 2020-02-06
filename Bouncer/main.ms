#binds go in here

bind('player_login',null,null,@event,
	@player = @event['player']
	if(not(has_permission(@player,'server.join')),
		modify_event('kickmsg','You do not have permission to join this server!')
		modify_event('result','KICK_OTHER')
	)
)