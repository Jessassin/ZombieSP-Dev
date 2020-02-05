bind('player_interact',null,array(block: 'FLOWER_POT'),@event,
	cancel()
	@yml = yml_decode(read('config.yml'))
	@item = @event['item']
	if(@item == 0,
		return(),
	)
	@dataname = data_name(@item)
	@itemname = reg_replace(' ','_',@dataname)
	@player = @event['player']
	if(array_contains_ic(array_keys(@yml),@itemname),
		_melt_item(@itemname,@player),
		tmsg(@player,'You can not break down that item!')
	)
)