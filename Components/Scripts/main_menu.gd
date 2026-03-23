extends CanvasLayer


@onready var start: Control = %Start
@onready var play: Button = %Play
@onready var quit: Button = %Quit


@onready var servet_type: Control = %"Servet type"
@onready var singlplayer: Button = %Singlplayer
@onready var _multiplayer: Button = %Multiplayer
@onready var back: Button = %Back


const SINGLPLAYER = preload("uid://b03vhiivy18vm")
const MULTIPLAYER = preload("uid://dsqeghera187s")
const PLAYER = preload("uid://br70xqp46f5hb")


func _ready() -> void:
	play.pressed.connect(show_server)
	quit.pressed.connect(func():get_tree().quit())
	
	singlplayer.pressed.connect(_join_world)
	_multiplayer.pressed.connect(_join_server)
	back.pressed.connect(show_main_menu)
	
	if OS.has_feature('Server'):
		NetworkHandler.start_server()
		add(MULTIPLAYER)
		hide()

func show_server():
	start.hide()
	servet_type.show()

func show_main_menu():
	servet_type.hide()
	start.show()

func _join_world():
	add(SINGLPLAYER)
	hide()
	

func _join_server():
	NetworkHandler.join_server()
	add(MULTIPLAYER)
	
	hide()


func add(world_type):
	var new_world = world_type.instantiate()
	get_tree().current_scene.add_child.call_deferred(new_world)
	return new_world
