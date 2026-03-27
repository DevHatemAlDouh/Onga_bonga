class_name XP_Orb
extends Area2D

signal free_me

var Xp: int

func _ready() -> void:
	Xp = randi_range(1,5)

func get_xp() -> int:
	return Xp

func depleted():
	free_me.emit()

func distance_formula(me:Vector2,target:Vector2):
	var distance = sqrt((me.x - target.x)**2 + (me.y - target.y)**2)
	return distance

func makepath():
	var Players = get_tree().get_nodes_in_group("Player")
	var Nerast_player : Vector2
	var shotrest_distance = 100000
	for i in Players.size():
		if shotrest_distance >= distance_formula(global_position,Players[i].global_position):
			Nerast_player = Players[i].global_position
			shotrest_distance = distance_formula(global_position,Players[i].global_position)
	return Nerast_player
