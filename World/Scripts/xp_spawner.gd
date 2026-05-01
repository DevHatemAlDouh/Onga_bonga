extends MultiplayerSpawner

const XP_ORB = preload("uid://dh4wshijexd47")
@onready var _xp: Node2D = %XP
@onready var _enemys: Node2D = %Enemys

func _on_enemy_spawner_enemy_is_ready(enemy: Variant) -> void:
	enemy.Not_live_xp.connect(spawn_xp.bind(enemy))

func spawn_xp(enemy):
	var xp = XP_ORB.instantiate()
	xp.global_position = enemy.global_position
	xp.name = str(randi())
	get_node(spawn_path).add_child.call_deferred(xp,true)
	xp.free_me.connect(func():xp.queue_free())
	enemy.queue_free()

func _process(_delta: float) -> void:
	if _enemys.get_children().size() == 0:
		for i in _xp.get_children():
			i.rawnd_end = true
