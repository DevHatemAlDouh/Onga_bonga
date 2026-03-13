extends Node2D

var Can_attack := true
@export var Speed : float
@export var Attack_duration : Timer
var Enemy:Vector2

func _process(delta: float) -> void:
	if !Can_attack:
		position += Speed * to_local(Enemy) * delta

func Attack(target:Vector2):
	Enemy = target
	Attack_duration.start()
	Can_attack = false

func set_attack_speed(time:float):
	Attack_duration.wait_time = time

func get_attack_speed():
	return Attack_duration.wait_time

func set_movment_speed(value:float):
	Speed = value

func get_movment_speed():
	return Speed


func _on_attack_timeout() -> void:
	Can_attack = true
	queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if get_parent().get_parent().name != area.get_parent().get_parent().name:
		queue_free()
