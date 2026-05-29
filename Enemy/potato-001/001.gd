extends CharacterBody2D

var Speed = 200

@onready var Xp = preload("uid://dh4wshijexd47")

@onready var MILK = preload("uid://n5hp6gvreery")

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

@export var animation: AnimationPlayer

signal Not_live_xp

signal Not_live_heling_item

var _multiplayer: bool

func _physics_process(_delta: float) -> void:
	if _multiplayer:
		if !is_multiplayer_authority():return
	if !animation.is_playing():
		animation.play("Move")
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	var GP_b = global_position.x
	if GameManager.is_it_day_yeat():
		Speed = 100
	else:
		Speed = 200
	velocity = dir * Speed
	move_and_slide()
	if GP_b > global_position.x:
		$AnimatedSprite2D.flip_h = true
	else :
		$AnimatedSprite2D.flip_h = false

func distance_formula(me:Vector2,target:Vector2):
	var distance = sqrt((me.x - target.x)**2 + (me.y - target.y)**2)
	return distance

func makepath():
	var players = get_tree().get_nodes_in_group("Player")
	var Nerast_player : Vector2
	var shotrest_distance = 100000
	for i in players.size():
		if shotrest_distance >= distance_formula(global_position,players[i].global_position):
			Nerast_player = players[i].global_position
			shotrest_distance = distance_formula(global_position,players[i].global_position)
	nav_agent.target_position = Nerast_player

func xp():
	var Xp_orb = Xp.instantiate()
	Xp_orb.set_deferred("global_position",global_position)
	await get_tree().process_frame
	return Xp_orb

func Heling():
	var heling_item = MILK.instantiate()
	heling_item.set_deferred("global_position",global_position)
	await get_tree().process_frame
	return heling_item

func _on_timer_timeout() -> void:
	makepath()

func _on_health_health_depleted() -> void:
	if is_multiplayer_authority():
		var luck = randf_range(1,10)
		if _multiplayer:
			if luck > 8:
				Not_live_heling_item.emit()
			else:
				Not_live_xp.emit()
		else :
			if luck > 8:
				get_parent().get_parent().get_node("Heling items").add_child(await Heling(),true)
			else :
				get_parent().get_parent().get_node("XP").add_child(await xp(),true)
			queue_free()

func _on_hurt_box_got_hit() -> void:
	if is_multiplayer_authority():
		$AnimatedSprite2D.modulate = "#808080"
		$"Got hit".start()

func _on_got_hit_timeout() -> void:
	if is_multiplayer_authority():
		$AnimatedSprite2D.modulate = "#ffffff"
