#binds go in here

bind('entity_damage', null, null, @event,
	#Check if is ENTITY_ATTACK or PROJECTILE
	if(not(or(@event['cause'] == 'ENTITY_ATTACK', @event['cause'] == 'PROJECTILE')),
		die()
	)
	#If it is damage dealt to a player, die. Prevents trying to give money to mobs
	if(@event['type'] == 'PLAYER',
		die()
	)
	#If the damage amount equals 0, cancel. Prevents errors when dividing by 0
	if(equals(@event['amount'],0),
		die()
	)
	#assign variables
	if(@event['cause'] == 'ENTITY_ATTACK',
		assign(@player,@event['damager']),
		assign(@player,@event['shooter'])
	)
	assign(@damage,@event['amount'])
	#get random number between 1 and 7
	assign(@random,rand(1,7))
	#divide random number by 10
	assign(@fraction,divide(@random,10))
	#multiply amount of damage by that value
	assign(@money,multiply(@fraction,@damage))
	#round to nearest dollar
	assign(@rounded,round(@money))
	#add that money to the players account
	_acc_add(@player,@rounded)
)

#remove XP from dropping from mobs / players
bind('entity_death', null, null, @event,
	modify_event('xp',0)
)