extends Control

@export var day_time: int 
@export var nigth_time: int
@export var timer: Timer
@export var animation: AnimationPlayer


func _ready() -> void:
	timer.timeout.connect(Day_state)

func _process(_delta: float) -> void:
	if timer.is_stopped():
		if GameManager.is_it_day_yeat():
			animation.play_backwards("DNC")
			timer.start(day_time)
		else:
			animation.play("DNC")
			timer.start(nigth_time)
func Day_state():
	if GameManager.is_it_day_yeat():
		GameManager.Day_night_cycle = GameManager.Cycle.Night
	else:
		GameManager.Day_night_cycle = GameManager.Cycle.Day
