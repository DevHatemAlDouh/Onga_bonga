extends Control

@onready var color_rect: ColorRect = %ColorRect
@onready var animation: AnimationPlayer = %Animation
@onready var day_night_2: Sprite2D = %DayNight2


func _process(_delta: float) -> void:
	if GameManager.get_time_progres():
		timer_tick()

func timer_tick():
	move_clock()
	if GameManager.get_tiker() > GameManager.get_day_time() && GameManager.is_it_day_yeat():
		GameManager.set_night()
		animation.play("DNC")
	if GameManager.get_tiker() == 0:
		GameManager.set_day()
		animation.play_backwards("DNC")



func move_clock():
	var current_time = GameManager.get_tiker()
	var day_time = GameManager.get_day_time()
	var night_time = GameManager.get_night_time()
	
	var percentage = 0.0
	
	if current_time < day_time:
		var day_progress = float(current_time) / float(day_time)
		percentage = day_progress * 180.0
	else:
		var night_elapsed = float(current_time - day_time)
		var night_progress = night_elapsed / float(night_time)
		percentage = 180.0 + (night_progress * 180.0)
	day_night_2.rotation_degrees = percentage
