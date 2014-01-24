#procedure definitions go here

# proc(_testdb,
	# @username = player()
	# @query = query('testserver', 'SELECT * FROM test.balances WHERE username = (?)', (@username))
	# msg(@query)
# )

proc(_create_account,@player,
	@query = query('testserver', 'SELECT * FROM test.balances WHERE username = (?)', (@player))
	if(length(@query) < 1,
		query('testserver', 'INSERT INTO test.balances (username, wallet_balance, bank_balance) VALUES (?,0,0)', (@player)),
		return()
	)
)

proc(_acc_set,@username,@balance,
	query('testserver', 'UPDATE balances SET wallet_balance=(?) WHERE username=(?)', @balance,@username)
)

proc(_bacc_set,@username,@balance,
	query('testserver', 'UPDATE balances SET bank_balance=(?) WHERE username=(?)', @balance,@username)
)

proc(_acc_balance,@username,
	@query = query('testserver', 'SELECT * FROM test.balances WHERE username = (?)', @username)
	#broadcast(@query[0])
	@balance = @query[0]['wallet_balance']
	return(@balance)
)

proc(_bacc_balance,@username,
	@query = query('testserver', 'SELECT * FROM test.balances WHERE username = (?)', @username)
	#broadcast(@query[0])
	@balance = @query[0]['bank_balance']
	return(@balance)
)