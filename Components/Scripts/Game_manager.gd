extends Node

var players = {}

var abilities = ["max_hp","movement_speed","attack_damege"]

var player_info = {
	"level":0
	,"xp":{
		"max_xp":100
		,"current_xp":0
	}
	,"abilities":{
		"max_hp":0
		,"movement_speed":0
		,"attack_damege":0
		,"lavel_scaling":{
			0:10
			,1:25
			,2:70
		}
	}
	,"info":{
		"max_hp":0
		,"movement_speed":0
		,"attack_damege":0
	}
	,"description":{
		"max_hp":"Max health + "
		,"movement_speed":"Movement speed + "
		,"attack_damege":"Attack damege + "
	}
}

var wapons = {
	"scyth":{
		"base_damage" : 7
		,"range": 250
		,"scyths": 1
	}
}

var _day_time: int = 1200 
var _nigth_time: int = 1500 
var _time: int = 0
var _time_progres: bool = true


func tiker():
	if _time_progres:
		_time += 1
		if _time == _nigth_time:
			_time = 0

func set_tiker_day():
	_time = 0

func set_tiket_nigth():
	_time = _day_time

func get_tiker():
	return _time

func set_time_progres(time_progres):
	_time_progres = time_progres

func get_time_progres():
	return _time_progres

func set_day():
	Day_night_cycle = _Cycle.Day

func set_day_time(time):
	if time >= 0:
		_day_time = time

func get_day_time():
	return _day_time

func set_nigth():
	Day_night_cycle = _Cycle.Night

func set_nigth_time(time):
	if time >= 0:
		_nigth_time = time

func get_nigth_time():
	return _nigth_time

enum _Cycle {
	Day,
	Night
}

var Day_night_cycle = _Cycle.Day


func is_it_day_yeat():
	if Day_night_cycle == _Cycle.Day:
		return true
	else:
		return false


func add_xp(value):
	pass
	#const  XpOrb = preload("uid://dh4wshijexd47")
	#var Xp = XpOrb.instantiate()
	#Xp.set_xp(value)
	#print(value, Xp)
	#received_XP.emit(Xp.get_xp())
	#Xp.queue_free()
