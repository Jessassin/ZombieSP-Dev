#procedure definitions go here

proc(_update_moneycount,
	foreach(all_players(),@p,
		# wallet max (only syncs every 10 seconds
		if(has_value(concat('economy.wallet.max.', @p),
			@wsize = get_value(concat('economy.wallet.max.balance.', @p)),
			@wsize = _wallet_size(@p)
			store_value(concat('economy.wallet.max.', @p), @wsize)
		)
		# wallet balance (only syncs every 3 seconds)
		if(has_value(concat('economy.wallet.balance.', @p),
			@bal = get_value(concat('economy.wallet.balance.', @p)),
			@bal = _acc_balance(@p)
			store_value(concat('economy.wallet.max.', @p), @bal)
		)
		
		@percent = divide(@wsize,100)
		# moved balance > max check to where it gets set instead of here
		set_plevel(@p,round(@bal))
		set_pexp(@p,round(divide(@bal,@percent)))
	)
)

# wallet procs made more sense in economy (economy uses them anyway which means they require it...)
# therefore it made more sense that xpwallet only hooked into economy, not both hooking into each other