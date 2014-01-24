#bind on join event
bind(player_join, null, null, @event,
	#send welcome message
	tmsg(concat("You have a balance of: ", acc_balance(@event['player'])))
)