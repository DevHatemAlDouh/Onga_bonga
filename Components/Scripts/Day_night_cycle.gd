extends Control

@export var timer: Timer
@export var animation: AnimationPlayer

func _ready() -> void:
	timer.timeout.connect(Day_state)

func _process(_delta: float) -> void:
	if timer.is_stopped() && GameManager.get_time_progres():
		if GameManager.is_it_day_yeat():
			animation.play_backwards("DNC")
			timer.start(GameManager.get_day_time())
		else:
			animation.play("DNC")
			timer.start(GameManager.get_nigth_time())

func Day_state():
	if GameManager.is_it_day_yeat() && GameManager.get_time_progres():
		GameManager.set_nigth()
	else:
		GameManager.set_day()
