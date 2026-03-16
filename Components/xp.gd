class_name XP
extends Node

signal max_xp_changed(diff: float)
signal xp_changed(diff: float)
signal level_up


@export var max_xp: float :set = set_max_xp, get =get_max_xp

@onready var xp:float = 0 :set = set_xp, get = get_xp

func set_max_xp(value: float):
	max_xp = value
	max_xp_changed.emit(max_xp)

func get_max_xp() -> float:
	return max_xp

func set_xp(value: float):
	if value != 0:
		xp += value
		if xp >= get_max_xp():
			xp -= get_max_xp()
			Livel_up()
		xp_changed.emit(xp)

func get_xp() -> float:
	return xp

func Livel_up():
	level_up.emit()
	set_max_xp(get_max_xp()+(get_max_xp()/10))
