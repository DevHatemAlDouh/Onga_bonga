extends Node

const PLAYER = preload("uid://br70xqp46f5hb")

const IP_ADDRESS :String = "127.0.0.1"

const PORT: int = 9999

var peer:= ENetMultiplayerPeer.new()

func start_server() -> void:
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(spawn_player)
	multiplayer.peer_disconnected.connect(remove_player)


func join_server() -> void:
	peer.create_client(IP_ADDRESS,PORT)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(spawn_player)
	multiplayer.peer_disconnected.connect(remove_player)
	multiplayer.connected_to_server.connect(on_connect_to_server)


func on_connect_to_server():
	spawn_player(multiplayer.get_unique_id())

func spawn_player(id: int) -> void:
	if id == 1: return
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
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = null
	clean_up_signals()

func clean_up_signals():
	multiplayer.peer_connected.disconnect(spawn_player)
	multiplayer.peer_disconnected.disconnect(remove_player)
	multiplayer.connected_to_server.disconnect(on_connect_to_server)
