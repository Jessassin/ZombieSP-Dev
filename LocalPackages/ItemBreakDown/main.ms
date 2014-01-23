bind(player_interact,null,array(block: data_values(Flower_pot)),@event,
	cancel()
	@yml = yml_decode(read('config.yml'))
	@item = @event['item']
	if(@item == 0,
		#broadcast('Cancelling event')
		return(),
		#broadcast('Item not 0')
	)
	@dataname = data_name(@item)
	@itemname = reg_replace(' ','_',@dataname)
	@player = @event['player']
	if(array_contains_ic(array_keys(@yml),@itemname),
		_melt_item(@itemname,@player),
		tmsg(@player,'You can not break down that item!')
	)
)