_respawn_tick_start()

bind('player_interact',null,array(block: 'HAY_BLOCK', button: 'right', hand: 'main_hand'),@event) {
	if(@event['block'] === null) {
		return()
	}
	@yml = yml_decode(read('config.yml'))
	set_block(@event['location'], 'AIR')
	make_effect(@event['location'], 'ZOMBIE_DESTROY_DOOR:1', 8)
	@entitylocation = @event['location']
	@entitylocation['x'] = @entitylocation['x'] + 0.5
	@entitylocation['y'] = @entitylocation['y'] + 0.5
	@entitylocation['z'] = @entitylocation['z'] + 0.5
	@effect = spawn_entity('AREA_EFFECT_CLOUD', 1, @entitylocation, closure(@id){set_entity_spec(@id, associative_array(duration: 1, radius: 0, particle: 'CRIT'))};)[0]
	play_entity_effect(@effect, 'ARROW_PARTICLES')
	@low = @yml['drops']['low']
	@high = @yml['drops']['high']
	if(@event['block'] == 'HAY_BLOCK') { #TODO: THIS NEEDS TO BE A QUERY
		cancel()
		for(assign(@i,0), @i < length(@low), @i++) {
			@item = array_keys(@low)[@i]
			@chance = @low[@item]['chance']
			#if the drop chance is less than 100%, spawn on percentage chance
			if(@chance < 100) {
				if(rand(0,100) <= @chance) {
					@uuid = spawn_entity('dropped_item', 1, @event['location'])
					set_entity_spec(@uuid[0], array(itemstack: array(meta: null, name: @item, qty: 1), pickupdelay: 1))
				}
			} else {
				#else, spawn item
				@uuid = spawn_entity('dropped_item', 1, @event['location'])
				set_entity_spec(@uuid[0], array(itemstack: array(meta: null, name: @item, qty: 1), pickupdelay: 1))
			}
		}
	}
	if(@event['block'] == 'HAY_BLOCK') { #TODO: THIS NEEDS TO BE A QUERY
		cancel()
		for(assign(@i,0), @i < length(@high), @i++) {
			@item = array_keys(@high)[@i]
			@chance = @high[@item]['chance']
			#if the drop chance is less than 100%, spawn on percentage chance
			if(@chance < 100) {
				if(rand(0,100) <= @chance) {
					@uuid = spawn_entity('dropped_item', 1, @event['location'])
					set_entity_spec(@uuid[0], array(itemstack: array(meta: null, name: @item, qty: 1), pickupdelay: 1))
				}
			} else {
				#else, spawn item
				@uuid = spawn_entity('dropped_item', 1, @event['location'])
				set_entity_spec(@uuid[0], array(itemstack: array(meta: null, name: @item, qty: 1), pickupdelay: 1))
			}
		}
	}
}