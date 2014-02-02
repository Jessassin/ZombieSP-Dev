#binds go in here

bind(player_join,null,null,@event,
	#broadcast(@event['player'])
	tmsg(@event['player'], concat('You have ', _get_mail_count(@event['player']), ' new messages.'))
)