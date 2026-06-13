extends Control

@export var messages: TextEdit
@export var line_edit: LineEdit
@export var timer: Timer


var show_input : bool = false
var msg: String


func _ready() -> void:
	timer.timeout.connect(hide_log)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Show_input"):
		line_edit.select_all_on_focus = false
		show_input = true
		line_edit.grab_focus.call_deferred()
		messages.show()
		messages.modulate = Color(1,1,1,1)
	
	if event.is_action_pressed("command_mode"):
		line_edit.select_all_on_focus = false
		show_input = true
		line_edit.grab_focus.call_deferred()
		line_edit.text += "/"
		messages.show()
		messages.modulate = Color(1,1,1,1)
	
	if event.is_action_pressed("Settings") && show_input:
		show_input = false
		line_edit.clear()
	
	if event.is_action_pressed("Send"):
		line_edit.select_all_on_focus = true
		timer.stop()
		messages.modulate = Color(1,1,1,1)
		Command()
	

func _process(_delta: float) -> void:
	line_edit.visible = show_input

func hide_log():
	var tween = get_tree().create_tween()
	tween.tween_property(
		messages,
		"modulate", 
		Color(1,1,1,0),
	 	1.0
		)

func Command():
	msg = line_edit.text
	if !msg.is_empty():
		var msg_info = msg.to_lower().split(" ")
		if msg_info[0] == "/help": # help commands
			messages.text += str("set -> change the time and day nigth cycle\n")
			if msg_info.size() > 1 && msg_info[1] == "set": # set timer
				messages.text += str("time -> change the time and day nigth cycle\n")
				if msg_info.size() > 2 && msg_info[2] == "time": # set timer
					messages.text += str("""
					stop -> stop day nigth cycle from prograsing\n
					start -> cantnue day nigth cycle progras\n
					day -> change day nigth cycle to day\n
					night -> change day nigth cycle to nigth\n
					""")
		if msg_info[0] == "/set": # set commands
################################################################################
			if msg_info.size() > 1 && msg_info[1] == "time": # set timer
				if msg_info.size() > 2 && msg_info[2] == "stop": # set stop day nigth cycle
					GameManager.set_time_progres(false)
					messages.text += str("time stoped\n")
				if msg_info.size() > 2 && msg_info[2] == "start": # set start day nigth cycle
					GameManager.set_time_progres(true)
					messages.text += str("time start\n")
				if msg_info.size() > 2 && msg_info[2] == "day": # set day nigth cycle to day
					GameManager.set_day()
					messages.text += str("set time day\n")
				if msg_info.size() > 2 && msg_info[2] == "nigth": # set day nigth cycle to day
					GameManager.set_nigth()
					messages.text += str("set time day\n")
			line_edit.clear()
			timer.start()
		else:
			messages.text += str("command is not corract \nuse /help to see all potions \n")
	
	
	
