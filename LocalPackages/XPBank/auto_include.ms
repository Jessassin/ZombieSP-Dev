#procedure definitions go here

proc(_bank_deposit,@player,@amt,
	if(not(is_numeric(@amt)),
		if(equals_ic(@amt,'all'),
			@amt = _acc_balance(@player),
			die(concat(@amt,' is not a valid amount'))
		)
	)
	if(_acc_balance(@player) < @amt,
		die(concat('You do not have $',@amt,' to deposit!'))
	)
	_acc_subtract(@player,@amt)
	_bacc_add(@player,@amt)
	tmsg(@player,concat('You deposited $',@amt,' to your bank account!'))
	tmsg(@player,concat('Wallet balance: $',_acc_balance(@player)))
	tmsg(@player,concat('Bank balance: $',_bacc_balance(@player)))
)

proc(_bank_withdraw,@player,@amt,
	if(not(is_numeric(@amt)),
		if(equals_ic(@amt,'all'),
			@amt = _bacc_balance(@player),
			die(concat(@amt,' is not a valid amount'))
		)
	)
	if(_bacc_balance(@player) < @amt,
		die(concat('You do not have $',@amt,' to withdraw!'))
	)
	_bacc_subtract(@player,@amt)
	_acc_add(@player,@amt)
	tmsg(@player,concat('You withdrew $',@amt,' from your bank account!'))
	tmsg(@player,concat('Wallet balance: $',_acc_balance(@player)))
	tmsg(@player,concat('Bank balance: $',_bacc_balance(@player)))
)

proc(_bank_balance,@player,
	return(_bacc_balance(@player))
)

proc(_bank_premium_upgrade,@player,
	if(_account_is_premium(@player),
		tmsg(@player,concat('Your account is already premium!'))
		return()
	)
	if(_bacc_balance(@player) < 1000,
		tmsg(@player,concat('You need at least $1000 in your bank account!'))
		return()
	)
	_bacc_subtract(@player,1000)
	query('testserver','UPDATE player_meta SET premium = 1 WHERE username = (?)',@player)
	tmsg(@player,concat('You have upgraded your account to a premium account!'))
)

proc(_account_is_premium,@player,
	@premium = query('testserver','SELECT premium FROM player_meta WHERE username = (?)',@player)[0]['premium']
	return(@premium)
)