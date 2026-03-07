extends CharacterBody2D

@onready var Stone = preload("res://Projectile/stone.tscn")

const SPEED = 500.0
var dir : Vector2
@export var Wapons: Node2D
@export var Can_attack: Timer
var can_attack = true

func _unhandled_input(_event: InputEvent) -> void:
	dir.x = Input.get_axis("Left", "Right")
	dir.y = Input.get_axis("Top", "Down")
	dir = dir.normalized()

func distance_formula(me:Vector2,target:Vector2):
	var distance = sqrt((me.x - target.x)**2 + (me.y - target.y)**2)
	return distance

func makepath():
	var Enames = get_parent().get_parent().find_child("Enemys").get_children()
	var Nerast_enamy : Vector2
	var shotrest_distance = 100000
	for i in Enames.size():
		if shotrest_distance >= distance_formula(global_position,Enames[i].global_position):
			Nerast_enamy = Enames[i].global_position
			shotrest_distance = distance_formula(global_position,Enames[i].global_position)
	return Nerast_enamy

func Wapon():
	var Wapon = Wapons.get_children()
	var stone_tamp = Stone.instantiate()
	add_child(stone_tamp)
	
	stone_tamp.position = Wapon[0].position
	stone_tamp.Attack(makepath())
	
	return stone_tamp.get_attack_speed()

func _physics_process(_delta: float) -> void:
	if makepath() != Vector2.ZERO && can_attack:
		Can_attack.start(Wapon())
		can_attack = false
	velocity = dir * SPEED
	move_and_slide()


func _on_can_attack_timeout() -> void:
	can_attack = true
