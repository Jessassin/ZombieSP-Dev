#procedure definitions go here

proc(_get_mail_count, @player,
	@query = query('testserver', 'SELECT * FROM mail WHERE to = (?)', (@player))
	return(length(@query))
)

proc(_get_mail, @player,
	@query = query('testserver', 'SELECT * FROM mail WHERE to = (?)', (@player))
	for(assign(@i, 0), @i < length(@query), @i++,
		tmsg(@player, concat(@query[@i]['from']), ': ', @query[@i]['message'])
	)
)

proc(_send_mail, @from, @to, @msg,
	query('testserver', 'INSERT INTO mail (from, to, message, cleared) VALUES (?,?,?,\'FALSE\')', @player, @from, @msg)
)

proc(_clear_mail, @player,
	query('testserver', 'UPDATE mail SET cleared=\'TRUE\' WHERE to=(?)', (@player))
)

proc(_singplural, @num,
	if(equals(@num, 1),
		return(''),
		return('s')
)