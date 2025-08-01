extends CharacterBody2D
class_name BaseNPC
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var debug_label: Label = $debug_label

@export var SPEED:float=100
@onready var thinking_timer: Timer = $ThinkingTimer
@onready var food_timer: Timer = $FoodTimer

enum STATES {WaitingForTable,Thinking,WaitingForFood,Eating,Leaving}

var _current_table:Table
var _state:STATES=STATES.WaitingForTable

func _ready() -> void:
	_current_table=Tablemanager.get_free_table()
	#if _current_table!=null:
	#	navigation_agent_2d.target_position=_current_table.sitting_marker.global_position


func _physics_process(delta: float) -> void:
	update_debug_label()
	updateMovement()
	move()

func processWaitingForTable()->void:
	if navigation_agent_2d.target_position==Vector2.ZERO:
		if _current_table!=null:
			navigation_agent_2d.target_position=_current_table.sitting_marker.global_position

	if navigation_agent_2d.is_navigation_finished():
		global_position = _current_table.sitting_marker.global_position
		velocity = Vector2.ZERO
		rotation=0
		_state = STATES.Thinking


func processThinking()->void:
	if thinking_timer.is_stopped():
		thinking_timer.start()

func processWaitingForFood()->void:
	food_timer.start()

func processEating()->void:
	pass

func processLeaving()->void:
	pass


func move() -> void:
	if navigation_agent_2d.is_navigation_finished():
		velocity = Vector2.ZERO
		return

	var next_position: Vector2 = navigation_agent_2d.get_next_path_position()

	# Optional: extra safety distance check
	if global_position.distance_to(next_position) < 4:
		velocity = Vector2.ZERO
		return

	rotation = global_position.direction_to(next_position).angle()
	velocity = transform.x * SPEED
	move_and_slide()


func sit_down():
	# Play sit animation, wait for food, etc.
	# After eating...
	await get_tree().create_timer(3).timeout
	_current_table.release()
	queue_free()

func update_debug_label()->void:
	var s:String=""
	s+="NavFinished:%s\n"%navigation_agent_2d.is_navigation_finished()
	s+="TargetReached:%s\n"%navigation_agent_2d.is_target_reached()
	s+="Target:%s\n"%navigation_agent_2d.target_position
	s += "DistanceToNext: %.2f\n" % global_position.distance_to(navigation_agent_2d.get_next_path_position())
	s += "STATE: %s\n" % STATES.find_key(_state)

	debug_label.text=s
	debug_label.rotation=-rotation

func request_table():
	var table:Table = Tablemanager.get_free_table()
	if table:
		table.reserve(self)
		navigation_agent_2d.target_position = table.markers.get_child(0).global_position
		_current_table=table
	else:
		print("No free tables available!")


func updateMovement()->void:
	match _state:
		STATES.WaitingForTable:
			processWaitingForTable()
		STATES.Thinking:
			processThinking()
		STATES.WaitingForFood:
			processWaitingForFood()
		STATES.Eating:
			processEating()
		STATES.Leaving:
			processLeaving()


func _on_thinking_timer_timeout() -> void:
	_state=STATES.WaitingForFood


func _on_food_timer_timeout() -> void:
	GameManager.gameOver()
