extends CharacterBody2D

@onready var Stone = preload("uid://8hh3mh3k5e4n")
@onready var Card = preload("uid://derukomogf7bf")
@onready var Scythe = preload("uid://dpx6sxbrn7p1h")
@onready var wapon: Marker2D = %Wapon
@onready var camera_2d: Camera2D = %Camera2D
@onready var ui: CanvasLayer = %UI
@onready var settings: Control = %Settings
@onready var lobby_id: Label = %"Lobby Id"
@onready var copy_lobby_id: Button = %"Copy Lobby Id"
@onready var leave: Button = %Leave
@onready var retry: Button = %Retry
@onready var lobby_info: HBoxContainer = %"Lobby info"
@onready var ping: Label = %Ping
@onready var ping_timeout: Timer = %Ping_timeout
@onready var animation_tree: AnimationTree = %AnimationTree
@onready var cards: Control = %Cards

@export var Can_attack: Timer
@export var Death_screen : Control
@export var Player_UI : Control
@export var Can_level_up : TextureRect
@export var command: Control

var SPEED = 500.0
var base_attack = 5
var _multiplayer : bool 
var can_attack = true
var Death = false
var is_moving = false
var is_using_scythe = false
var is_using_hoe = false
var live_cards = []

func _enter_tree() -> void:
	if _multiplayer:
		set_multiplayer_authority(int(name))

func _ready() -> void:
	GameManager.player_info["info"]["movement_speed"] = SPEED
	GameManager.player_info["info"]["attack_damege"] = base_attack
	ping_timeout.timeout.connect(func():rpc("Ping",Time.get_ticks_msec()))
	if is_multiplayer_authority():
		camera_2d.make_current()
	else:
		ui.hide()

@rpc ("any_peer","call_local")

func Ping(sent_time):
	ping_timeout.start()
	ping.text = "Ping: "+str(Time.get_ticks_msec() - sent_time)+"ms"
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Attack 1") && can_attack:
		$hoe2/HitBox.set_damage(GameManager.player_info["info"]["attack_damege"])
		is_using_hoe = true
		can_attack = false
		Can_attack.start()
	elif event.is_action_released("Attack 1"):
		is_using_hoe = false
	
	if event.is_action_pressed("Attack 2") && !is_using_scythe:
		Wapon_scythe()
		is_using_scythe = true
	elif event.is_action_released("Attack 2"):
		is_using_scythe = false

func _physics_process(_delta: float) -> void:
	if !Death:
		if NetworkHandler.tube_enabed:
			lobby_info.show()
			lobby_id.text = "Lobby Id: "+str(NetworkHandler.tube_client.session_id)
			copy_lobby_id.pressed.connect(func(): DisplayServer.clipboard_set(NetworkHandler.tube_client.session_id))
		if Input.is_action_just_pressed("Settings") && !command.show_input:
			settings.visible = !settings.visible
			Engine.time_scale = !settings.visible
		if _multiplayer and !NetworkHandler.tube_enabed:
			if !is_multiplayer_authority():return
		if !command.show_input:
			velocity = Input.get_vector("Left", "Right","Top", "Down").normalized() * SPEED
		_animation()
		move_and_slide()

func _animation():
	if velocity != Vector2.ZERO:
		is_moving = true 
	else:
		is_moving = false
	if is_using_scythe:
		animation_tree["parameters/wapon/attack-transition/transition_request"] = "swing"
	else:
		animation_tree["parameters/wapon/attack-transition/transition_request"] = "swing-backward"
	if is_using_hoe:
		animation_tree["parameters/Add/add_amount"] = is_using_hoe
	else:
		animation_tree["parameters/Add/add_amount"] = is_using_hoe
		

	animation_tree["parameters/move/blend_amount"] = is_moving
	animation_tree["parameters/attack/blend_amount"] = is_using_scythe
	if is_moving:
		animation_tree["parameters/run/legs/blend_position"] = velocity
		animation_tree["parameters/hoe/blend_position"] = velocity
		animation_tree["parameters/run/body/blend_position"] = velocity
		animation_tree["parameters/idel/legs/blend_position"] = velocity
		animation_tree["parameters/idel/body/blend_position"] = velocity
		animation_tree["parameters/wapon/swing/blend_position"] = velocity
		animation_tree["parameters/wapon/swing-backward/blend_position"] = velocity
	


func distance_formula(me:Vector2,target:Vector2):
	return sqrt((me.x - target.x)**2 + (me.y - target.y)**2)

func makepath():
	var Enemys = get_tree().get_nodes_in_group("Enemy")
	var Nerast_enamy : Vector2 
	var All_enemys :Dictionary[Node, Vector2] = {}
	var shotrest_distance = 100000
	if Enemys.size():
		for i in Enemys.size():
			var Enemy_distance = distance_formula(global_position,Enemys[i].global_position)
			if Enemy_distance < 1000:
				show()
				if shotrest_distance >= Enemy_distance:
					Nerast_enamy = Enemys[i].global_position
					All_enemys.get_or_add(Enemys[i],Nerast_enamy)
					shotrest_distance = Enemy_distance
	return All_enemys.find_key(Nerast_enamy)

func Wapon_stone():
	var enemy = makepath()
	if enemy != null:
		var stone = Stone.instantiate()
		get_tree().current_scene.add_child(stone)
		stone.Attack(enemy)
		stone.global_position = wapon.global_position
		return stone.get_attack_speed()

func Wapon_scythe():
	if GameManager.wapons["scyth"]["scyths"] > 0:
		var scythe = Scythe.instantiate()
		get_tree().current_scene.add_child(scythe)
		scythe.Attack(self,get_global_mouse_position())
		scythe.global_position = wapon.global_position
		GameManager.wapons["scyth"]["scyths"] -= 1

func _on_can_attack_timeout() -> void:
	can_attack = true

func death():
	Death = true 
	Death_screen.visible = Death
	if !_multiplayer:
		Engine.time_scale = 0



func _on_health_health_depleted() -> void:
	death()

func _on_xp_level_up() -> void:
	var card_content = []
	
	var can_move_on = true
	var cards_in_the_filed = 0
	while can_move_on:
		var card_content_id = randi_range(0,2)
		if cards_in_the_filed > 2:
			can_move_on = false
		elif GameManager.player_info["abilities"][GameManager.abilities[card_content_id]] >= 2:
			card_content.append(card_content_id)
		elif card_content_id not in card_content:
			var card = Card.instantiate()
			cards.call_deferred("add_child",card)
			await get_tree().process_frame
			cards_in_the_filed += 1
			card_content.append(card_content_id)
			card.run(card_content_id)
			card.global_position = Vector2(120 * cards_in_the_filed,120)
			live_cards.append(card)
			card.clicked.connect(delete_cards)
	Can_level_up.visible = true

func delete_cards():
	print(live_cards)
	for i in live_cards:
		i.queue_free()
	live_cards.clear()

func _on_replay_pressed() -> void:
	if _multiplayer:
		leave.disabled = true
		retry.disabled = true
		NetworkHandler.leave_server()
	else:
		if !is_multiplayer_authority():return
		Engine.time_scale = 1
	get_tree().reload_current_scene()
