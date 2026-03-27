class_name Heling_tiems
extends Area2D

signal free_me

var Extra_health :int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Extra_health = randi_range(1,2)

func get_extra_health() -> int:
	return Extra_health

func depleted():
	free_me.emit()
