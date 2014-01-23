#procedure definitions go here

proc(_testdb,
#query('testserver', 'INSERT INTO `balances` (`username`) VALUES (`Jessassin`)')
#query('testserver', 'INSERT INTO balances (username, wallet_balance, bank_balance) VALUES (?, ?, ?)', 'Jessassin', 0, 0)
#return(@resultTable)
	try(
    assign(@resultTable, query('testserver', 'SELECT * FROM balances'))
		broadcast(concat(@resulttable['username']))
		broadcast(concat(@resulttable['wallet_valance']))
		broadcast(concat(@resulttable['']))
    return(@resultTable)
		, #catch
    return('Database error')
	)
)