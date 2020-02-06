#procedure definitions go here

proc('_acc_exists',@player) {
	@query = query('testserver', 'SELECT * FROM balances WHERE username = (?)', (@player))
	if(length(@query) < 1) {
		return(false)
	} else {
		return(true)
	}
}

proc('_create_account',@player) {
	if(!_acc_exists(@player)) {
		query('testserver', 'INSERT INTO balances (username, wallet_balance, bank_balance) VALUES (?,0,0)', (@player))
	}
}

proc('_acc_set',@username,@balance) {
	query('testserver', 'UPDATE balances SET wallet_balance=(?) WHERE username=(?)', @balance,@username)
}

proc('_bacc_set',@username,@balance) {
	query('testserver', 'UPDATE balances SET bank_balance=(?) WHERE username=(?)', @balance,@username)
}

proc('_acc_balance',@username) {
	@query = query('testserver', 'SELECT wallet_balance FROM balances WHERE username = (?)', @username)
	@balance = @query[0]['wallet_balance']
	return(@balance)
}

proc('_bacc_balance',@username) {
	@query = query('testserver', 'SELECT bank_balance FROM balances WHERE username = (?)', @username)
	@balance = @query[0]['bank_balance']
	return(@balance)
}

proc('_acc_add',@username,@amount) {
	@balance = _acc_balance(@username)
	@set = @balance + @amount
	_acc_set(@username,@set)
}

proc('_acc_subtract',@username,@amount) {
	@balance = _acc_balance(@username)
	@set = @balance - @amount
	_acc_set(@username,@set)
}

proc('_acc_multiply',@username,@amount) {
	@balance = _acc_balance(@username)
	@set = @balance * @amount
	_acc_set(@username,@set)
}

proc('_acc_divide',@username,@amount) {
	@balance = _acc_balance(@username)
	@set = @balance / @amount
	_acc_set(@username,@set)
}

proc('_bacc_add',@username,@amount) {
	@balance = _bacc_balance(@username)
	@set = @balance + @amount
	_bacc_set(@username,@set)
}

proc('_bacc_subtract',@username,@amount) {
	@balance = _bacc_balance(@username)
	@set = @balance - @amount
	_bacc_set(@username,@set)
}

proc('_bacc_multiply',@username,@amount) {
	@balance = _bacc_balance(@username)
	@set = @balance * @amount
	_bacc_set(@username,@set)
}

proc('_bacc_divide',@username,@amount) {
	@balance = _bacc_balance(@username)
	@set = @balance / @amount
	_bacc_set(@username,@set)
}