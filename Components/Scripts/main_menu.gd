extends CanvasLayer


@onready var start: Control = %Start
@onready var play: Button = %Play
@onready var quit: Button = %Quit


@onready var servet_type: Control = %"Servet type"
@onready var local_mode: Button = %"Local mode"
@onready var online_mode: Button = %"Online mode"
@onready var to_main_menu: Button = %"To main menu"

@onready var local: Control = %"Local"
@onready var singlplayer: Button = %Singlplayer
@onready var _multiplayer: Button = %Multiplayer

@onready var local_server: Control = %"Local server"
@onready var host: Button = %Host
@onready var player: Button = %Player

@onready var online_server: Control = %"Online server"
@onready var lobbies: VBoxContainer = %Lobbies

@onready var add_lobby: Button = %"Add lobby"
@onready var join_lobby: Button = %"Join lobby"
@onready var line_edit: LineEdit = %LineEdit

const PLAYER = preload("uid://br70xqp46f5hb")


func _ready() -> void:
	play.pressed.connect(show_server)
	quit.pressed.connect(func():get_tree().quit())
	
	local_mode.pressed.connect(show_local)
	online_mode.pressed.connect(show_oline)
	to_main_menu.pressed.connect(show_main_menu)
	
	
	singlplayer.pressed.connect(_join_world)
	_multiplayer.pressed.connect(show_local_server)
	
	host.pressed.connect(start_local_host)
	player.pressed.connect(_join_local_host)
	
	add_lobby.pressed.connect(Add_lobby)
	join_lobby.disabled = true
	join_lobby.pressed.connect(join)
	line_edit.text_changed.connect(update_session)
	
	NetworkHandler.tube_client.error_raised.connect(on_error_reised.bind())


func show_server():
	start.hide()
	servet_type.show()
	local.hide()
	online_server.hide()
	local_server.hide()

func show_main_menu():
	start.show()
	servet_type.hide()
	local.hide()
	online_server.hide()
	local_server.hide()

func show_local():
	start.hide()
	servet_type.hide()
	local.show()
	online_server.hide()
	local_server.hide()
	
func show_local_server():
	start.hide()
	servet_type.hide()
	local.hide()
	online_server.hide()
	local_server.show()

func show_oline():
	NetworkHandler.enabel_tube()
	start.hide()
	servet_type.hide()
	local.hide()
	online_server.show()
	local_server.hide()


func _join_world():
	NetworkHandler.add_world("SINGLPLAYER")
	hide()


func start_local_host():
	NetworkHandler.start_server()
	await get_tree().create_timer(0.1).timeout
	NetworkHandler.is_host = true
	NetworkHandler.add_world("MULTIPLAYER")
	hide()

func _join_local_host():
	NetworkHandler.join_server()
	NetworkHandler.add_world("MULTIPLAYER")
	hide()

func _join_lobby():
	NetworkHandler.add_world("MULTIPLAYER")
	hide()

func join():
	join_lobby.disabled = true
	await NetworkHandler.tube_join(line_edit.text)
	multiplayer.connected_to_server.connect(_join_lobby)
	

func update_session(new_text: String):
	if new_text != "":
		join_lobby.disabled = false


func Add_lobby():
	NetworkHandler.tube_create()
	NetworkHandler.add_world("MULTIPLAYER")
	hide()


func _on_to_server_type_pressed() -> void:
	show_server()


func on_error_reised(_error,_message):
	line_edit.text = ""
	NetworkHandler.clean_up_signals()
