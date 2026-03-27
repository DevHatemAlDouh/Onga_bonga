class_name Heling_items_detactor
extends Area2D

signal received_HP

@export var health :Health

func _ready() -> void:
	connect("area_entered",_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Heling_tiems:
		var Hp: Heling_tiems = area
		if Hp != null:
			received_HP.emit()
			health.health += Hp.get_extra_health()
			if get_parent()._multiplayer:
				Hp.depleted()
			else:
				Hp.queue_free()
