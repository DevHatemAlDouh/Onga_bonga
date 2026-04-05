extends CharacterBody2D

@onready var Stone = preload("uid://8hh3mh3k5e4n")
@onready var wapons: Node2D = %Wapons
@onready var camera_2d: Camera2D = %Camera2D
@onready var ui: CanvasLayer = %UI
@onready var settings: Control = %Settings
@onready var lobby_id: Label = %"Lobby Id"
@onready var copy_lobby_id: Button = %"Copy Lobby Id"
@onready var leave: Button = %Leave
@onready var retry: Button = %Retry
@onready var lobby_info: HBoxContainer = %"Lobby info"


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

func wapon():
	var Wapon = wapons.get_children()
	var enemy = makepath()
	if enemy != Vector2.ZERO:
		var stone = Stone.instantiate()
		get_tree().current_scene.add_child(stone)
		stone.Attack(enemy)
		stone.global_position = Wapon[0].global_position
		return stone.get_attack_speed()

func _physics_process(_delta: float) -> void:
	if !Death:
		if NetworkHandler.tube_enabed:
			lobby_info.show()
			lobby_id.text = "Lobby Id: "+str(NetworkHandler.tube_client.session_id)
			copy_lobby_id.pressed.connect(func(): DisplayServer.clipboard_set(NetworkHandler.tube_client.session_id))
			#DisplayServer.clipboard_set(NetworkHandler.tube_client.session_id)
		if Input.is_action_just_pressed("Settings"):
			settings.visible = !settings.visible
			Engine.time_scale = !settings.visible
		if can_attack:
			var new_wapon = wapon()
			if new_wapon:
				Can_attack.start(new_wapon)
				can_attack = false
		if _multiplayer and !NetworkHandler.tube_enabed:
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
		leave.disabled = true
		retry.disabled = true
		NetworkHandler.leave_server()
	else:
		Engine.time_scale = 1
	get_tree().reload_current_scene()
