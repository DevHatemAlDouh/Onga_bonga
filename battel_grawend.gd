extends Node2D

@onready var E001 = preload("uid://is57xa3if7hx")

@export var Enamy_number : int

@export var Enemy_list : Node2D

func Spawner():
	for i in Enamy_number:
		var RNG = RandomNumberGenerator.new()
		var pos : Vector2
		pos.x = RNG.randf_range(-1000,1000)
		pos.y = RNG.randf_range(-1000,1000)
		var Enamy = E001.instantiate()
		Enamy.global_position = pos
		Enemy_list.add_child(Enamy)

func _process(_delta: float) -> void:
	if Enemy_list.get_children().size() == 0:
		Spawner()
