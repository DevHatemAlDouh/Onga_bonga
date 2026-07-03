extends Node

var players = {}

var wapons = {
	"scyth":{
		"base_damage" : 7
		,"range": 250
		,"scyths": 1
	}
}

var _day_time: int = 20 #sec
var _nigth_time: int = 8 #sec
var _time_progres: bool = true

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
