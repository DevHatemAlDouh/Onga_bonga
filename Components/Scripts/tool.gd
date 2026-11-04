extends Control

@onready var tools: Sprite2D = %Tools
@onready var control: Control = %Control
@onready var action: Sprite2D = %Action
@onready var total_usege: Label = %Total_usege

@export var tool_name: String
@export var tool_icon: Texture2D
@export var tool_icon_hframes: int = 1
@export var tool_icon_frame: int = 0

@export var action_icon: Texture2D
@export var action_icon_hframes: int = 1
@export var action_icon_frame: int = 0


func _ready() -> void:
	tools.texture = tool_icon
	tools.hframes = tool_icon_hframes
	tools.frame = tool_icon_frame
	
	action.texture = action_icon
	action.hframes = action_icon_hframes
	action.frame = action_icon_frame
	

func _process(_delta: float) -> void:
	if tool_name != "scythe":
		total_usege.visible = false
		if GameManager.weapons[tool_name]["can_use"]:
			control.visible = false
			return
			
		control.visible = true
		
		var total_cooldown = GameManager.weapons[tool_name]["cooldown"]
		var start_time = GameManager.weapons[tool_name]["cooldown_start_at"]
		var current_tick = GameManager.get_tiker()
		
		var elapsed = current_tick - start_time
		var progress = elapsed / total_cooldown
		
		control.size.y = progress * 32.0
		control.position.y = 32.0 - (progress * 32.0)
		
		if elapsed >= total_cooldown:
				GameManager.weapons[tool_name]["can_use"] = true
	else:
		total_usege.visible = true
		total_usege.text = str(GameManager.weapons[tool_name]["total_usage"])
