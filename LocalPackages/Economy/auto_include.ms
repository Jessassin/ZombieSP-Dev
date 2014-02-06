#procedure definitions go here

proc(_create_account,@player,
	@query = query('testserver', 'SELECT * FROM balances WHERE username = (?)', (@player))
	if(length(@query) < 1,
		query('testserver', 'INSERT INTO balances (username, wallet_balance, bank_balance) VALUES (?,0,0)', (@player)),
		return()
	)
)

proc(_acc_set,@p,@balance,
	if(has_value(concat('economy.wallet.max.', @p),
		@wsize = get_value(concat('economy.wallet.max.', @p)),
		@wsize = _wallet_size(@p))
	)
	if(gt(@balance,@wsize),
		tmsg(@p,concat('You can only hold ', @wsize, ' in your wallet!'))
		tmsg(@p,'Upgrade your wallet by typing /wallet upgrade')
		tmsg(@p,'Open a bank account to deposit excess money.')
		@balance = @wsize
	)
	set_value(concat('economy.wallet.balance.', @p), @balance)
	query('testserver', 'UPDATE balances SET wallet_balance=(?) WHERE username=(?)', @balance,@p)
)

proc(_bacc_set,@username,@balance,
	query('testserver', 'UPDATE balances SET bank_balance=(?) WHERE username=(?)', @balance,@username)
)

proc(_acc_balance,@username,
	@query = query('testserver', 'SELECT * FROM balances WHERE username = (?)', @username)
	@balance = @query[0]['wallet_balance']
	return(@balance)
)

proc(_bacc_balance,@username,
	@query = query('testserver', 'SELECT * FROM balances WHERE username = (?)', @username)
	@balance = @query[0]['bank_balance']
	return(@balance)
)

proc(_acc_add,@username,@amount,
	@balance = _acc_balance(@username)
	@set = @balance + @amount
	_acc_set(@username,@set)
)

proc(_acc_subtract,@username,@amount,
	@balance = _acc_balance(@username)
	@set = @balance - @amount
	_acc_set(@username,@set)
)

proc(_acc_multiply,@username,@amount,
	@balance = _acc_balance(@username)
	@set = @balance * @amount
	_acc_set(@username,@set)
)

proc(_acc_divide,@username,@amount,
	@balance = _acc_balance(@username)
	@set = @balance / @amount
	_acc_set(@username,@set)
)

proc(_bacc_add,@username,@amount,
	@balance = _bacc_balance(@username)
	@set = @balance + @amount
	_bacc_set(@username,@set)
)

proc(_bacc_subtract,@username,@amount,
	@balance = _bacc_balance(@username)
	@set = @balance - @amount
	_bacc_set(@username,@set)
)

proc(_bacc_multiply,@username,@amount,
	@balance = _bacc_balance(@username)
	@set = @balance * @amount
	_bacc_set(@username,@set)
)

proc(_bacc_divide,@username,@amount,
	@balance = _bacc_balance(@username)
	@set = @balance / @amount
	_bacc_set(@username,@set)
)

proc(_acc_balance_cached, @p,
	if(has_value(concat('economy.wallet.balance.', @p)),
		@bal = get_value(concat('economy.wallet.balance.', @p)),
		@bal = _acc_balance(@p)
		store_value(concat('economy.wallet.balance.', @p), @bal)
	)
	return(@bal)
)

#given player, returns wallet size
proc(_wallet_size,@player,
	#wallet size = 250 * stored value
	#i.e. if stored value is 3, wallet size is $750
	@query = query('testserver', 'SELECT wallet_size FROM player_meta WHERE username=?', @player)
	#if player does not exist in table, add them to table (server automatically adds wallet size attribute)
	if(length(@query) < 1,
		query('testserver', 'INSERT INTO player_meta (username) VALUES (?)', @player)
		@query = query('testserver', 'SELECT wallet_size FROM player_meta WHERE username=?', @player)
	)
	@wsize = @query[0][wallet_size] * 250
	return(@wsize)
)

proc(_upgrade_wallet,@player,@amount,
	if(@amount < 1,
		return()
	)
	if(not(is_numeric(@amount)),
		return()
	)
	@query = query('testserver', 'SELECT wallet_size FROM player_meta WHERE username=?', @player)
	@size = @query[0]['wallet_size']
	@newsize = @size + @amount
	query('testserver', 'UPDATE player_meta SET wallet_size=? WHERE username=?', @newsize,@player)
	set_value(concat('economy.wallet.max.', @player), (@newsize * 250))
	return(@newsize * 250)
)