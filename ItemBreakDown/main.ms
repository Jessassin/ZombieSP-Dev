bind('player_interact',null,array(block: 'FLOWER_POT', button: 'right', hand: 'main_hand'),@event) {
	@config = yml_decode(read('config.yml'))
	@item = @event['item']
	if(@item == null) {
		return()
	} else {
		cancel()
	}
	if(array_contains_ic(array_keys(@config),@event['item']['name'])) {
		_melt_item(@event['item']['name'],@event['player'])
	} else {
		tmsg(@event['player'],'You can not break down that item!')
	}
}