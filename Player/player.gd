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
var _multiplayer : bool 
var can_attack = true
var Death = false

func _enter_tree() -> void:
	if _multiplayer:
		set_multiplayer_authority(int(name))

func _ready() -> void:
	
	if is_multiplayer_authority():
		camera_2d.make_current()
	else:
		ui.hide()

func wapon():
	var Wapon = wapons.get_children()
	var stone_tamp = Stone.instantiate()
	stone_tamp.hide()
	get_tree().current_scene.add_child(stone_tamp)
	
	stone_tamp.global_position = Wapon[0].global_position
	stone_tamp.Attack()
	
	return stone_tamp.get_attack_speed()

func _physics_process(_delta: float) -> void:
	if !Death:
		if can_attack:
			Can_attack.start(wapon())
			can_attack = false
		if _multiplayer:
			if !is_multiplayer_authority():return
		velocity = Input.get_vector("Left", "Right","Top", "Down").normalized() * SPEED
		move_and_slide()

func _on_can_attack_timeout() -> void:
	can_attack = true

func death():
	Death = true 
	Death_screen.visible = Death
	if _multiplayer:
		if !is_multiplayer_authority():return
		Engine.time_scale = 0

func _on_health_health_depleted() -> void:
	death()

func _on_xp_level_up() -> void:
	Can_level_up.visible = true


func _on_replay_pressed() -> void:
	if _multiplayer:
		NetworkHandler.leave_server()
	get_tree().reload_current_scene()
	Engine.time_scale = 1
