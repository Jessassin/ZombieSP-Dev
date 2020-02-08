proc('_melt_item',@itemname,@player,@location,
	@yml = yml_decode(read('config.yml'))
	@itemsettings = @yml[to_lower(@itemname)]
	@selecteditem = pinv(@player,pheld_slot())
	if(is_array(@selecteditem['meta']) && array_index_exists(@selecteditem['meta'],'damage')) {
		@damage = @selecteditem['meta']['damage']
	} else {
		@damage = 0
	}
	@durability = @itemsettings['durability']
	@damagepercent = @damage / @durability * 100
	@ingot_cost = @itemsettings['ingot_cost']
	@returningots = floor(@ingot_cost - ((@damagepercent / 100) * @ingot_cost))
	if(@returningots == 0) {
		die("Breaking this down would return no materials!")
	} else {
		@location['x'] = @location['x'] + 0.5
		@location['y'] = @location['y'] + 0.5
		@location['z'] = @location['z'] + 0.5
		ptake_item(@player,@selecteditem)
		@uuid = spawn_entity('dropped_item', 1, @location)
		set_entity_spec(@uuid[0], array(itemstack: array(meta: null, name: @itemsettings['material'], qty: @returningots), pickupdelay: 1))
	}
)