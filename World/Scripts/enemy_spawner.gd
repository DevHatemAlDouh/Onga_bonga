extends MultiplayerSpawner

@onready var E001 = preload("uid://is57xa3if7hx")
@onready var enamy_pos: Node2D = %Enamy_pos

signal enemy_is_ready(enemy)


func _on_spawner_timer_timeout() -> void:
	for i in enamy_pos.get_children().size():
		var Enamy = E001.instantiate()
		Enamy.global_position = enamy_pos.get_children()[i].global_position
		Enamy.name = str(randi())
		Enamy._multiplayer = true
		get_node(spawn_path).add_child(Enamy)
		enemy_is_ready.emit(Enamy)
		enamy_pos.get_children()[i].queue_free()
