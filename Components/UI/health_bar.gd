extends ProgressBar

@export var timar :Timer
@export var damage_bar :ProgressBar

@export var HP :Node

var prev_health: int

func _set_heath():
	value = HP.get_health()
	if HP.get_health() < prev_health:
		timar.start()
	else:
		damage_bar.value = HP.get_health()

func _ready() -> void:
	max_value = HP.get_max_health()
	value = HP.get_max_health()
	damage_bar.max_value = HP.get_max_health()
	damage_bar.value = HP.get_max_health()


func _on_timer_timeout() -> void:
	damage_bar.value = HP.get_health()


func _on_health_health_changed(_diff: int) -> void:
	_set_heath()

func _on_hurt_box_got_hit() -> void:
	prev_health = HP.get_health()


func _on_heling_items_detactor_received_hp() -> void:
	_set_heath()
