extends MultiplayerSpawner

@onready var Spawn_point = preload("uid://cbr4er6rl5qob")
@onready var enemys: Node2D = %Enemys
@onready var enamy_pos: Node2D = %Enamy_pos
@onready var spawner_timer: Timer = %"Spawner timer"
@onready var start: Button = %Start

@export var Enamy_number : int

func _ready() -> void:
	start.pressed.connect(_spawn)

func Spawner():
	for i in randf_range(1,Enamy_number):
		var pos : Vector2
		pos.x = randf_range(-1000,1000)
		pos.y = randf_range(-1000,1000)
		var SP = Spawn_point.instantiate()
		SP.global_position = pos
		SP.name = str(randi())
		get_node(spawn_path).add_child(SP,true)
	spawner_timer.start()

func _spawn() -> void:
	if get_tree().get_nodes_in_group("Player").size() > 0:
			if enamy_pos.get_children().size() == 0:
				if enemys.get_children().size() == 0:
					Spawner()
