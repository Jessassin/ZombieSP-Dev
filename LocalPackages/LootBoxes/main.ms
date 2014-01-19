@file = read('config.yml')
@yml = yml_decode(@file)
bind(player_interact,null,array(block: '33:6','33:7'),@event,
	set_block_at(@event['location'],0)
	make_effect(@event['location'],'STEP_SOUND:5',8)
	set_timeout(400,closure(break_block(@event['location'])))
	broadcast(@event['block'])
	if(@event['block'] == '33:6',
		drop_item(@event['location'],array(type: 3),true),
		drop_item(@event['location'],array(type: 264),true)
	)
)