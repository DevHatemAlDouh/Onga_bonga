class_name XP_Orn
extends Area2D

signal free_me

var Xp: float

func set_xp(value:float):
	Xp = value

func get_xp() -> float:
	return Xp

func depleted():
	free_me.emit()
func distance_formula(me:Vector2,target:Vector2):
	var distance = sqrt((me.x - target.x)**2 + (me.y - target.y)**2)
	return distance

func makepath():
	var Players = get_parent().get_parent().find_child("Players").get_children()
	var Nerast_player : Vector2
	var shotrest_distance = 100000
	for i in Players.size():
		if shotrest_distance >= distance_formula(global_position,Players[i].global_position):
			Nerast_player = Players[i].global_position
			shotrest_distance = distance_formula(global_position,Players[i].global_position)
	return Nerast_player
