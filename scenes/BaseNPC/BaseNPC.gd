extends CharacterBody2D
class_name BaseNPC

@export var SPEED:float=100
@export var CASH:int=3

@onready var debug_label: Label = $debug_label
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var thinking_timer: Timer = $ThinkingTimer
@onready var food_timer: Timer = $FoodTimer
@onready var eating_timer: Timer = $EatingTimer
@onready var thinking_cloud: Sprite2D = $thinkingCloud
@onready var food_icon: Sprite2D = $FoodIcon
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var sound: AudioStreamPlayer2D = $Sound

enum STATES {WaitingForTable,Thinking,WaitingForFood,Eating,Leaving}

static var _num_of_customers:int=0
var _current_table:Table
var _state:STATES=STATES.WaitingForTable
var _food:Item
var _exitPos:Vector2
var _leavingFlag:bool=false

func _ready() -> void:
	_num_of_customers+=1
	Tablemanager.request_table(self)
	#if _current_table!=null:
	#	navigation_agent_2d.target_position=_current_table.sitting_marker.global_position


func _physics_process(delta: float) -> void:
	#update_debug_label()
	updateMovement()
	move()

func processWaitingForTable()->void:
	if navigation_agent_2d.is_navigation_finished()and _current_table!=null:
		global_position = _current_table.sitting_marker.global_position
		velocity = Vector2.ZERO
		rotation=0
		_state = STATES.Thinking

func processThinking()->void:
	if thinking_timer.is_stopped():
		thinking_timer.start()

func processWaitingForFood()->void:
	if food_timer.is_stopped():
		food_timer.start()
		_food=FoodManager.get_random_food()
		thinking_cloud.show()
		food_icon.show()
		food_icon.texture=_food.texture
	if _food==_current_table._item:
		_state=STATES.Eating
		thinking_cloud.hide()
		food_icon.hide()

func processEating()->void:
	if eating_timer.is_stopped():
		eating_timer.start()

func processLeaving()->void:
	if !_leavingFlag:
		SignalHub.emit_get_cash(CASH)
		debug_label.show()
		debug_label.text="+%d"%CASH
		sound.play()
		gpu_particles_2d.emitting=true
		_leavingFlag=true
		_current_table.release()
		navigation_agent_2d.target_position=GameManager.getExitMarker()
	if navigation_agent_2d.is_navigation_finished():
		var tween:Tween=create_tween()
		await tween.tween_property(self,"modulate",Color(0,0,0,0),1)
		_num_of_customers-=1
		tween.tween_callback(queue_free)



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

#func update_debug_label()->void:
	#var s:String=""
	#s+="NavFinished:%s\n"%navigation_agent_2d.is_navigation_finished()
	#s+="TargetReached:%s\n"%navigation_agent_2d.is_target_reached()
	#s+="Target:%s\n"%navigation_agent_2d.target_position
	#s += "DistanceToNext: %.2f\n" % global_position.distance_to(navigation_agent_2d.get_next_path_position())
	#s += "STATE: %s\n" % STATES.find_key(_state)

	#debug_label.text=s
	#debug_label.rotation=-rotation


func assign_table(table: Table) -> void:
	_current_table = table
	navigation_agent_2d.target_position = table.sitting_marker.global_position


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


func _on_eating_timer_timeout() -> void:
	_state=STATES.Leaving
