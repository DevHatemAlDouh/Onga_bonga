class_name HurtBox
extends Area2D


signal got_hit


@export var health :Health

func _ready() -> void:
	connect("area_entered",_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	
	if area is HitBox:
		var hitbox: HitBox = area
		if hitbox != null:
			if get_parent().is_in_group("Player") && hitbox.get_parent().is_in_group("Player_projectiles"):
				pass
			elif get_parent().is_in_group("Enemy") && hitbox.get_parent().is_in_group("Enemy"):
				pass
			else :
				got_hit.emit()
				health.health -= hitbox.damage
				
