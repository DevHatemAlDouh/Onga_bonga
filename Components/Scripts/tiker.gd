extends Node


func _process(_delta: float) -> void:
	if GameManager.get_time_progres():
		GameManager.tiker()
