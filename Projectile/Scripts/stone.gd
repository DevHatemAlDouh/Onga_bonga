extends Node2D

var Can_attack := true
@export var Speed : float
@export var Attack_duration : Timer
@export var animation : AnimationPlayer
@export var Homing:bool
var Enemy:Vector2

func _process(delta: float) -> void:
	if !Can_attack && Enemy != Vector2.ZERO:
		if !animation.is_playing():
			animation.play("Roling")
		if Homing:
			translate(Speed * to_local(makepath()) * delta)
		else:
			translate(Speed * to_local(Enemy) * delta)
func distance_formula(me:Vector2,target:Vector2):
	var distance = sqrt((me.x - target.x)**2 + (me.y - target.y)**2)
	return distance

func makepath():
	var Enemys = get_tree().get_nodes_in_group("Enemy")
	var Nerast_enamy : Vector2
	var shotrest_distance = 100000
	if Enemys.size():
		for i in Enemys.size():
			var Enemy_distance = distance_formula(global_position,Enemys[i].global_position)
			if Enemy_distance < 1000:
				show()
				if shotrest_distance >= Enemy_distance:
					Nerast_enamy = Enemys[i].global_position
					shotrest_distance = Enemy_distance
	return Nerast_enamy

func Attack():
	Enemy = makepath()
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
	if area.get_parent().get_parent().name == "Enemys":
		queue_free()
