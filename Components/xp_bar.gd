extends ProgressBar

@export var Xp :Node

var prev_xp: int

func _set_xp():
	value = prev_xp
	print(max_value,value)


func _ready() -> void:
	max_value = Xp.get_max_xp()
	value = Xp.get_xp()
	


func _on_xp_max_xp_changed(diff: int) -> void:
	max_value = diff


func _on_xp_xp_changed(diff: int) -> void:
	prev_xp = diff
	_set_xp()


func _on_xp_detactor_received_xp(XP_Orn: float) -> void:
	Xp.set_xp(XP_Orn)
