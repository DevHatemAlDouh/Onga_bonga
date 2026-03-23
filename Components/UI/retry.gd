extends Control


func _on_button_pressed() -> void:
	NetworkHandler.remove_player($"../../../../..".name)
	get_tree().reload_current_scene()
	Engine.time_scale = 1
