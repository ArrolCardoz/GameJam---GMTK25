extends Node2D
class_name WaveManager

@export var DAY:Dictionary[int,Waves]
@export var day_duration := 180.0 # 3 minutes
@export var spawner:Marker2D

var _dayTime:float=0
var _dayStarted:bool=false
var _nextWaveTime:float
var _current_day:int
var _current_waves:Waves
var _current_wave:Wave
var _counter:int=0

func _enter_tree() -> void:

	SignalHub.start_day.connect(startDay)
	SignalHub.game_over.connect(stopDay)
	SignalHub.you_win.connect(stopDay)

func stopDay()->void:
	_dayTime=0.0
	_dayStarted=false
	_counter=0

func startDay(numDay:int)->void:
	_dayTime=0
	_counter=0
	_current_day=numDay
	_dayStarted=true
	_current_waves=DAY[_current_day]
	_current_wave=_current_waves.wave[_counter]
	_nextWaveTime=_current_wave.time

func updateNextWaveTime()->void:
	_current_wave=_current_waves.wave[_counter]
	_nextWaveTime=_current_wave.time


func updateDayTimer(delta: float)->void:
	if !_dayStarted:return
	_dayTime+=delta
	if _dayTime>day_duration:
		_dayStarted=false
		stopDay()
		SignalHub.emit_day_over()
	if _nextWaveTime<=_dayTime:
		SignalHub.emit_spawn_customer(_current_wave.customerScene,spawner.global_position)
		_counter+=1
		updateNextWaveTime()

func _process(delta: float) -> void:
	updateDayTimer(delta)
