class_name XP_detactor

extends Area2D

signal received_XP(XP_Orn: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered",_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is XP_Orn:
		var Xp: XP_Orn = area
		if Xp != null:
			received_XP.emit(Xp.get_xp())
			Xp.depleted()
