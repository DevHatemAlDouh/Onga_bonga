extends Node2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer

enum Status {idel, feaz_one, in_zone, feaz_two}
var State = Status.idel
var Target_in_range: bool = false
var Target_one : Vector2
var Target_two 
@onready var nav: NavigationAgent2D = %NavigationAgent2D
@onready var timer: Timer = %Timer
@export var hit_box: HitBox
@onready var get_back: Timer = %Get_back

func _ready() -> void:
	get_back.timeout.connect(go_back)
	timer.timeout.connect(go_back)
	hit_box.set_damage(GameManager.wapons["scyth"]["base_damage"] + GameManager.player_info["info"]["attack_damege"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !animation_player.is_playing():
		animation_player.play("move")
	Move(delta)


func Attack(playeer,targer_pos):
	get_back.start()
	Target_in_range = false
	timer.stop()
	State = Status.feaz_one
	Target_one = targer_pos
	Target_two = playeer

func distance_formula(me:Vector2,target:Vector2) -> float:
	return sqrt((me.x - target.x)**2 + (me.y - target.y)**2)

func Throw(target: Vector2) -> void:
	var distance = distance_formula(self.global_position,target)
	if distance <= 3:
		State = Status.in_zone
		timer.start()
	nav.target_position = target

func go_back():
	State = Status.feaz_two

func Move(delta: float):
	if State == Status.feaz_one:
		Throw(Target_one)
		translate(5 * to_local(nav.get_next_path_position()) * delta)
	if State == Status.feaz_two:
		nav.target_position = Target_two.global_position
		translate(20 * to_local(nav.get_next_path_position()) * delta)
		if distance_formula(self.global_position,Target_two.global_position) <= 30:
			GameManager.wapons["scyth"]["scyths"] += 1
			queue_free()
