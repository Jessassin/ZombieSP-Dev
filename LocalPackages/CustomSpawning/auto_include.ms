proc(_spawn_mob,@type,@count,@locarray,
	#read config file
	@file = read('spawnconditions.yml')
	@yml = yml_decode(@file)
	broadcast(concat(@type,'SPAWNED!'))
	#replace colon with dash, to format for internal type in YML file
	@internaltype = to_upper(reg_replace(':','-',@type))
	##REMOVE LINE BELOW LATER##
	broadcast(@internaltype)
	#assign equipment array, and get keys
	@equipment = @yml['equipment'][@internaltype]
	@keys = array_keys(@equipment)
	#for each item in array, remove it if it is null
	foreach(@keys,@key,
		if(is_null(array_get(@equipment,@key)),
			array_remove(@equipment,@key),
			#else, format into new array using type: key
			
		)
	)
	#sets @id to the entity id of the spawned mob (since array is returned [0] is specified)
	@id = spawn_mob(@type,@count,@locarray)[0]
	broadcast(@id)
	set_mob_equipment(@id,@equipment)
	#set_mob_equipment(@id,array(WEAPON: array(type: 133)))
)


proc(_set_droprates,@id,

)