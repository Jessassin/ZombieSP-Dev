proc(_melt_item,@itemname,@player,
	@yml = yml_decode(read('config.yml'))
	@itemsettings = @yml[to_lower(@itemname)]
	@selecteditem = pinv(@player,null)
	@damage = @selecteditem['data']
	@durability = @itemsettings['durability']
	@damagepercent = @damage / @durability * 100
	@ingot_cost = @itemsettings['ingot_cost']
	@returningots = floor(@ingot_cost - ((@damagepercent / 100) * @ingot_cost))
	@i = 0
	@playerid = pinfo(@player)[13]
	foreach(pinv(@player),@slot,
		if(@slot == @selecteditem,
			set_inventory_item(@playerid,@i,null)
			pgive_item(@player,data_values(@itemsettings['material']),@returningots)
		)
		@i++
	)
)