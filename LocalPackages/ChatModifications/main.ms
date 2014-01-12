bind(player_chat,null,null,@event,
	@file = read('rankconfig.yml')
	@yml = yml_decode(@file)
	@prefix = ''
	@suffix = ''
	@groups = pgroup(player())
	foreach(@groups,@group,
		assign(@prefix, concat(@prefix,@yml[@group]['prefix']))
		assign(@suffix, concat(@suffix,@yml[@group]['suffix']))
	)
	@prefix = colorize(@prefix)
	@suffix = colorize(@suffix)
	modify_event('format',concat(@prefix,colorize('&f%1$s'),@suffix,colorize('&f: %2$s')))
)