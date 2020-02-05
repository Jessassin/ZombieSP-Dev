#procedure definitions go here

proc(_get_mail_count, @player,
	@query = query('testserver', 'SELECT * FROM mail WHERE recipient = ?', (@player))
	return(length(@query))
)

proc(_get_mail, @player,
	@query = query('testserver', 'SELECT * FROM mail WHERE recipient = ?', (@player))
	for(assign(@i, 0), @i < length(@query), @i++,
		tmsg(@player, concat(@query[@i]['sender']), ': ', @query[@i]['message'])
	)
)

proc(_send_mail, @sender, @recipient, @msg,
	query('testserver', 'INSERT INTO mail (sender, recipient, message, cleared) VALUES (?,?,?,\'FALSE\')', @sender, @recipient, @msg)
)

proc(_clear_mail, @player,
	query('testserver', 'UPDATE mail SET cleared=\'TRUE\' WHERE recipient = ?', (@player))
)

proc(_singplural, @num,
	if(equals(@num, 1),
		return(''),
		return('s')
	)
)