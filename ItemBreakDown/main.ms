bind('player_interact',null,array(block: 'FLOWER_POT', button: 'right', hand: 'main_hand'),@event,
	@yml = yml_decode(read('config.yml'))
	@item = @event['item']
	if(@item == null) {
		return()
	} else {
		cancel()
	}
	@dataname = data_name(@item)
	@itemname = reg_replace(' ','_',@dataname)
	@player = @event['player']
	if(array_contains_ic(array_keys(@yml),@itemname),
		_melt_item(@itemname,@player),
		tmsg(@player,'You can not break down that item!')
	)
)