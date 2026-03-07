extends CharacterBody2D

const Speed = 200
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * Speed
	move_and_slide()

func distance_formula(me:Vector2,target:Vector2):
	var distance = sqrt((me.x - target.x)**2 + (me.y - target.y)**2)
	return distance

func makepath():
	var players = get_parent().get_parent().find_child("Players").get_children()
	var Nerast_player : Vector2
	var shotrest_distance = 100000
	for i in players.size():
		if shotrest_distance >= distance_formula(global_position,players[i].global_position):
			Nerast_player = players[i].global_position
			shotrest_distance = distance_formula(global_position,players[i].global_position)
	nav_agent.target_position = Nerast_player

func _on_timer_timeout() -> void:
	makepath()


func _on_health_health_depleted() -> void:
	queue_free()
