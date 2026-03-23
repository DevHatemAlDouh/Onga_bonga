extends MultiplayerSpawner

const XP_ORB = preload("uid://dh4wshijexd47")

func _on_enemy_spawner_enemy_is_ready(enemy: Variant) -> void:
	enemy.Not_live.connect(spawn_xp.bind(enemy))

func spawn_xp(enemy):
	var xp = XP_ORB.instantiate()
	xp.set_xp(3)
	xp.global_position = enemy.global_position
	xp.name = str(randi())
	get_node(spawn_path).add_child.call_deferred(xp,true)
	xp.free_me.connect(func():xp.queue_free())
	enemy.queue_free()
