extends Node

const SINGLPLAYER = preload("uid://b03vhiivy18vm")
const MULTIPLAYER = preload("uid://dsqeghera187s")
const PLAYER = preload("uid://br70xqp46f5hb")
const TUBE_CONTEXT = preload("uid://dhuaw52wgojo4")

const IP_ADDRESS :String = "127.0.0.1"

const PORT: int = 0

var tube_client := TubeClient.new()
var tube_enabed = false
var is_host = false

var peer:= ENetMultiplayerPeer.new()

func enabel_tube():
	tube_enabed = true
	tube_client.context = TUBE_CONTEXT
	get_tree().root.add_child.call_deferred(tube_client)

func tube_create():
	is_host = true
	multiplayer.peer_connected.connect(spawn_player)
	multiplayer.peer_disconnected.connect(remove_player)
	tube_client.create_session()
	spawn_player(1)


func tube_join(secsion_id: String):
	multiplayer.peer_connected.connect(spawn_player)
	multiplayer.peer_disconnected.connect(remove_player)
	multiplayer.connected_to_server.connect(on_connect_to_server)
	tube_client.join_session(secsion_id)


func on_connect_to_server():
	spawn_player(multiplayer.get_unique_id())

func add_world(world_type):
	if world_type == "SINGLPLAYER":
		var new_world = SINGLPLAYER.instantiate()
		get_tree().current_scene.add_child(new_world)
	elif world_type == "MULTIPLAYER":
		var new_world = MULTIPLAYER.instantiate()
		get_tree().current_scene.add_child(new_world)

func spawn_player(id: int) -> void:
	if id == 1 and multiplayer.multiplayer_peer is ENetMultiplayerPeer: 
		return
	var pos : Vector2
	pos.x = randf_range(-1000,1000)
	pos.y = randf_range(-1000,1000)
	var player = PLAYER.instantiate()
	player._multiplayer = true
	player.name = str(id)
	player.global_position = pos
	get_tree().current_scene.add_child(player,true)

func remove_player(id):
	if str(id) == '1':
		leave_server()
	
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	var players_to_remove = players.find_custom(func(item): return item.name == str(id))
	if players_to_remove != -1:
		players[players_to_remove].queue_free()


func leave_server():
	tube_client.leave_session()
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = null
	clean_up_signals()

func clean_up_signals():
	multiplayer.peer_connected.disconnect(spawn_player)
	multiplayer.peer_disconnected.disconnect(remove_player)
	multiplayer.connected_to_server.disconnect(on_connect_to_server)


func _exit_tree() -> void:
	if tube_enabed:
		tube_client.leave_session()
