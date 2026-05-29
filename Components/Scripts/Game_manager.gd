extends Node

var players = {}

enum Cycle {
	Day,
	Night
}

var Day_night_cycle = Cycle.Day


func is_it_day_yeat():
	if Day_night_cycle == Cycle.Day:
		return true
	else:
		return false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
