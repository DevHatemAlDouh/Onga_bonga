extends CanvasLayer


@onready var start: Control = %Start
@onready var play: Button = %Play
@onready var _multiplayer: Button = %Multiplayer
@onready var quit: Button = %Quit


@onready var to_main_menu: Button = %"To main menu"



@onready var online_server: Control = %"Online server"

@onready var add_lobby: Button = %"Add lobby"
@onready var join_lobby: Button = %"Join lobby"
@onready var line_edit: LineEdit = %LineEdit

const PLAYER = preload("uid://br70xqp46f5hb")


func _ready() -> void:
	play.pressed.connect(_join_world)
	_multiplayer.pressed.connect(show_oline)
	to_main_menu.pressed.connect(show_main_menu)
	
	add_lobby.pressed.connect(Add_lobby)
	join_lobby.disabled = true
	join_lobby.pressed.connect(join)
	line_edit.text_changed.connect(update_session)
	
	NetworkHandler.tube_client.error_raised.connect(on_error_reised.bind())
	
	quit.pressed.connect(func():get_tree().quit())

func show_main_menu():
	start.show()
	online_server.hide()

func show_oline():
	NetworkHandler.enabel_tube()
	start.hide()
	online_server.show()


func _join_world():
	NetworkHandler.add_world("SINGLPLAYER")
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


func on_error_reised(_error,_message):
	line_edit.text = ""
	NetworkHandler.clean_up_signals()
