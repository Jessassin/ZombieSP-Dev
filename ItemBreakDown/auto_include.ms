proc('_melt_item',@itemname,@player,
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
		ptake_item(@player,@selecteditem)
		pgive_item(@player,data_values(@itemsettings['material']),@returningots)
	}
)