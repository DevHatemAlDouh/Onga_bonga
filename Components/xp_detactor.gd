class_name XP_detactor

extends Area2D

signal received_XP(XP: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered",_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is XP:
		var Xp: XP = area
		if Xp != null:
			received_XP.emit(Xp.get_xp())
			Xp.queue_free()
