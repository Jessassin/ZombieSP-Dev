#procedure definitions go here

proc('_update_moneycount') {
	foreach(all_players(), @p) {
		@wsize = _wallet_size(@p)
		@percent = divide(@wsize, 100)
		if(gt(_acc_balance(@p), @wsize)) {
			tmsg(@p,concat('You can only hold '@wsize' in your wallet!'))
			tmsg(@p,'Upgrade your wallet by typing /wallet upgrade')
			tmsg(@p,'Open a bank account to deposit excess money.')
			_acc_set(@p, @wsize)
		}
		set_plevel(@p,integer(round(_acc_balance(@p))))
		set_pexp(@p,integer(round(divide(_acc_balance(@p),@percent))))
	}
}

#given player, returns wallet size
proc('_wallet_size',@player) {
	#wallet size = 250 * stored value
	#i.e. if stored value is 3, wallet size is $750
	@query = query('testserver', 'SELECT wallet_size FROM player_meta WHERE username=?', @player)
	#if player does not exist in table, add them to table (server automatically adds wallet size attribute)
	if(length(@query) < 1) {
		query('testserver', 'INSERT INTO player_meta (username) VALUES (?)', @player)
		@query = query('testserver', 'SELECT wallet_size FROM player_meta WHERE username=?', @player)
	}
	@wsize = @query[0]['wallet_size'] * 250
	return(@wsize)
}

proc('_upgrade_wallet',@player,@amount) {
	if(@amount < 1) {
		return()
	}
	if(not(is_numeric(@amount))) {
		return()
	}
	@query = query('testserver', 'SELECT wallet_size FROM player_meta WHERE username=?', @player)
	@size = @query[0]['wallet_size']
	@newsize = @size + @amount
	query('testserver', 'UPDATE player_meta SET wallet_size=? WHERE username=?', @newsize, @player)
	return(@newsize * 250)
}