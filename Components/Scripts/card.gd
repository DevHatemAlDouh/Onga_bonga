extends Node2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var detals: Label = %Detals
@onready var icon: Sprite2D = %Icon
@onready var label: RichTextLabel = %Label
@onready var timer: Timer = %Timer

var max_width = 17
var text
var RNG:int
signal clicked

func run(num):
	RNG = num
	icon.frame = RNG
	
	display_text(str(GameManager.player_info["description"][GameManager.abilities[RNG]])+str(GameManager.player_info["abilities"]["lavel_scaling"][GameManager.player_info["abilities"][GameManager.abilities[RNG]]])+"%")
	
	var old_value = + GameManager.player_info["info"][GameManager.abilities[RNG]]
	var new_value = old_value + (old_value * GameManager.player_info["abilities"]["lavel_scaling"][GameManager.player_info["abilities"][GameManager.abilities[RNG]]]/100)
	label.text =  str(old_value) +" >>> [color=0f0]"+ str(new_value)

func display_text(text_to_display:String):
	var total_char_in_line = 0
	text = text_to_display.split(" ")
	for i in text:
		total_char_in_line += i.length()+1
		if total_char_in_line > max_width:
			detals.text += "\n"
			total_char_in_line = 0
			detals.text += i + " "
			total_char_in_line += i.length()+1
		else :
			detals.text += i + " "


func _on_timer_timeout() -> void:
	animation_player.play("Flip")


func _on_button_pressed() -> void:
	GameManager.player_info["abilities"][GameManager.abilities[RNG]] +=1
	clicked.emit()
