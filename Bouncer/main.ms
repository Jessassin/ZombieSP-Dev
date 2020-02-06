#binds go in here

bind('player_login',null,null,@event) {
	if(!has_permission(@event['player'],'server.join')) {
		modify_event('kickmsg','You do not have permission to join this server!')
		modify_event('result','KICK_OTHER')
	}
}