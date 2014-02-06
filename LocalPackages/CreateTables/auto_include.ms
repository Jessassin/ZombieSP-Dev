#procedure definitions go here

proc(_create_table,@tablename,
	@tables = array('balances','lootboxes',' player_meta','mail')
	if(@tablename == @tables[0],
		_create_balances()
	)
	if(@tablename == @tables[1],
		_create_lootboxes()
	)
	if(@tablename == @tables[2],
		_create_player_meta()
	)
	if(@tablename == @tables[3],
		_create_mail()
	)
	if(@tablename == 'alltables',
		_create_balances()		
		_create_lootboxes()		
		_create_player_meta()		
		_create_mail()
	)
)

proc(_create_balances,
	query('testserver','CREATE TABLE IF NOT EXISTS `balances` (
  `username` varchar(16) NOT NULL,
  `wallet_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  `bank_balance` decimal(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`username`)
	) ENGINE=MyISAM DEFAULT CHARSET=utf8;')
)

proc(_create_lootboxes,
	query('testserver','CREATE TABLE IF NOT EXISTS `lootboxes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `x` int(8) DEFAULT NULL,
  `y` int(3) DEFAULT NULL,
  `z` int(8) DEFAULT NULL,
  `quality` tinyint(1) DEFAULT '0',
  `enabled` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
	) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;')
)

proc(_create_player_meta,
	query('testserver','CREATE TABLE IF NOT EXISTS `player_meta` (
  `username` varchar(16) NOT NULL,
  `wallet_size` int(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`)
	) ENGINE=InnoDB DEFAULT CHARSET=utf8;')
)

proc(_create_mail,
	query('testserver','CREATE TABLE IF NOT EXISTS `mail` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `from` VARCHAR(16) NOT NULL,
  `to` VARCHAR(16) NOT NULL,
  `message` VARCHAR(256) NOT NULL,
  `cleared` TINYINT(1) NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC));')
)