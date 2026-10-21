extends Control

@onready var color_rect: ColorRect = %ColorRect
@onready var animation: AnimationPlayer = %Animation
@onready var day_nigth_2: Sprite2D = %DayNigth2

func _process(_delta: float) -> void:
	if GameManager.get_time_progres():
		timer_tick()
		
func timer_tick():
	GameManager.tiker()
	move_clock()
	if GameManager.get_tiker() > GameManager.get_day_time():
		Day_state()
	if GameManager.get_tiker() == 0:
		Day_state()

func Day_state():
	if GameManager.is_it_day_yeat():
		GameManager.set_nigth()
		animation.play("DNC")
	else:
		GameManager.set_day()
		animation.play_backwards("DNC")

func move_clock():
	var current_time = GameManager.get_tiker()
	var day_time = GameManager.get_day_time()
	var night_time = GameManager.get_day_time() - GameManager.get_nigth_time()
	
	var percentage = 0.0
	
	if current_time < day_time:
		var day_progress = float(current_time) / float(day_time)
		percentage = day_progress * 180.0
	else:
		var night_elapsed = float(current_time - day_time)
		var night_progress = night_elapsed / float(night_time)
		percentage = 180.0 + (night_progress * -180.0)
		
	day_nigth_2.rotation_degrees = percentage
