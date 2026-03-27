extends MultiplayerSpawner

const MILK = preload("uid://n5hp6gvreery")
func _on_enemy_spawner_enemy_is_ready(enemy: Variant) -> void:
	enemy.Not_live_heling_item.connect(spawn_heling_item.bind(enemy))

func spawn_heling_item(enemy):
	var item = MILK.instantiate()
	item.global_position = enemy.global_position
	item.name = str(randi())
	get_node(spawn_path).add_child.call_deferred(item,true)
	item.free_me.connect(func():item.queue_free())
	enemy.queue_free()
