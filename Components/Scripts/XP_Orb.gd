class_name XP_Orb
extends Area2D

signal free_me

var rawnd_end = false
var Speed = 5.0
var Xp: int

func _ready() -> void:
	Xp = randi_range(1,5)

func _process(delta: float) -> void:
	if rawnd_end:
		translate(Speed * to_local(makepath()) * delta)

func distance_formula(me:Vector2,target:Vector2):
	var distance = sqrt((me.x - target.x)**2 + (me.y - target.y)**2)
	return distance

func makepath():
	var Players = get_tree().get_nodes_in_group("Player")
	var Nerast : Vector2 
	var shotrest_distance = 100000
	if Players.size():
		for i in Players.size():
			var Distance = distance_formula(global_position,Players[i].global_position)
			if Distance < 1000:
				if shotrest_distance >= Distance:
					Nerast = Players[i].global_position
					shotrest_distance = Distance
	return Nerast

func set_xp(value):
	Xp = value

func get_xp() -> int:
	return Xp

func depleted():
	free_me.emit()
