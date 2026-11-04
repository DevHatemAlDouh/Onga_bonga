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

var weapons = {
	"scythe":{
		"base_damage" : 7
		,"cooldown_start_at": 0
		,"total_usage": 5
		,"can_use": true
	},
	"hoe":{
		"base_damage" : 2
		,"cooldown": 120
		,"cooldown_start_at": 0
		,"can_use": true
	}
}

var _day_time: int = 1200 
var _night_time: int = 300 
var _day_night_cycle: int = _day_time + _night_time
var _time: int = 0
var _time_progres: bool = true


func tiker():
	if _time_progres:
		_time += 1
		if _time == _day_night_cycle:
			_time = 0

func set_tiker_day():
	_time = 0

func set_tiket_night():
	_time = _day_time+1

func get_tiker():
	return _time

func get_full_day_night_cycle():
	return _day_night_cycle

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

func set_night():
	Day_night_cycle = _Cycle.Night

func set_night_time(time):
	if time >= 0:
		_night_time = time

func get_night_time():
	return _night_time

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
