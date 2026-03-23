extends CharacterBody2D

@onready var Stone = preload("uid://8hh3mh3k5e4n")
@onready var wapons: Node2D = %Wapons
@onready var camera_2d: Camera2D = %Camera2D
@onready var ui: CanvasLayer = %UI

const SPEED = 500.0
@export var Can_attack: Timer
@export var Death_screen : Control
@export var Player_UI : Control
@export var Can_level_up : TextureRect
var can_attack = true
var Death = false

func _enter_tree() -> void:
	set_multiplayer_authority(int(name))

func _ready() -> void:
	if is_multiplayer_authority():
		camera_2d.make_current()
	else:
		ui.hide()

func distance_formula(me:Vector2,target:Vector2):
	var distance = sqrt((me.x - target.x)**2 + (me.y - target.y)**2)
	return distance

func makepath():
	var Enames = get_tree().current_scene.get_child(1).find_child("Enemys").get_children()
	var Nerast_enamy : Vector2
	var shotrest_distance = 100000
	for i in Enames.size():
		if shotrest_distance >= distance_formula(global_position,Enames[i].global_position):
			Nerast_enamy = Enames[i].global_position
			shotrest_distance = distance_formula(global_position,Enames[i].global_position)
	return Nerast_enamy

func wapon():
	var Wapon = wapons.get_children()
	var stone_tamp = Stone.instantiate()
	add_child(stone_tamp)
	
	stone_tamp.position = Wapon[0].position
	stone_tamp.Attack(makepath())
	
	return stone_tamp.get_attack_speed()

func _physics_process(_delta: float) -> void:
	if !Death:
		if makepath() != Vector2.ZERO && can_attack:
			Can_attack.start(wapon())
			can_attack = false
		if !is_multiplayer_authority():return
		velocity = Input.get_vector("Left", "Right","Top", "Down").normalized() * SPEED
		move_and_slide()

func _on_can_attack_timeout() -> void:
	can_attack = true

func death():
	Death = true 
	Death_screen.visible = Death
	if !is_multiplayer_authority():return
	Engine.time_scale = 0

func _on_health_health_depleted() -> void:
	death()

func _on_xp_level_up() -> void:
	Can_level_up.visible = true
