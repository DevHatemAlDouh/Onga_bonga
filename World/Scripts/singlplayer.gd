extends Node2D

@onready var Spawn_point = preload("uid://cbr4er6rl5qob")

@onready var E001 = preload("uid://is57xa3if7hx")

@onready var spawner_timer: Timer = %"Spawner timer"

@export var Enamy_number : int

@export var Enemy_list : Node2D

@export var Enemy_spawner_list : Node2D

var enemy_pos : Array

func Spawner():
	var RNG = RandomNumberGenerator.new()
	for i in RNG.randf_range(1,Enamy_number):
		var pos : Vector2
		pos.x = RNG.randf_range(-1000,1000)
		pos.y = RNG.randf_range(-1000,1000)
		enemy_pos.append(pos)
		var SP = Spawn_point.instantiate()
		SP.global_position = pos
		Enemy_spawner_list.add_child(SP)
	spawner_timer.start()

func _process(_delta: float) -> void:
	if Enemy_spawner_list.get_children().size() == 0:
		if Enemy_list.get_children().size() == 0:
			if !GameManager.is_it_day_yeat():
				pass
				Spawner()


func _on_spawner_timer_timeout() -> void:
	for i in enemy_pos.size():
		var Enamy = E001.instantiate()
		Enamy.global_position = enemy_pos[i]
		Enemy_list.add_child(Enamy)
		Enemy_spawner_list.get_children()[i].queue_free()
	enemy_pos.clear()
