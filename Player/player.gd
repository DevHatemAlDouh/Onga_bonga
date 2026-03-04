extends CharacterBody2D


const SPEED = 500.0
var dir : Vector2

func _unhandled_input(_event: InputEvent) -> void:
	dir.x = Input.get_axis("Left", "Right")
	dir.y = Input.get_axis("Top", "Down")
	dir = dir.normalized()

func _physics_process(_delta: float) -> void:
	velocity = dir * SPEED
	move_and_slide()
	
