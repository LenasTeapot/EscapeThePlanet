extends Node2D

@onready var timer = $Timer
@onready var sprite = $Sprite2D

var active : bool
@export var DISABLED : bool = false
@export var startActive: bool = true
@export var time: int = 5
@export var texture: Texture
@export var temp_change_amount : float = 50.0

func _ready():
	if DISABLED == true:
		return
	#set up from metadata
	timer.wait_time = time
	sprite.set_texture(texture)
	active = startActive
			
	#connect to timer and start timer
	timer.timeout.connect(_toggle_state)
	timer.start()
	
	Events.MainIsReadySignal.connect(set_state)

func _process(_delta):
	if DISABLED == true:
		return
	#print(timer.time_left)
	set_path_position()

func set_state():
	set_path_position()
	sprite.visible = active
	if active == true:
		#Increase temp
		#print(name, " is active.")
		Events.SunStateChangeSignal.emit(self, temp_change_amount)
	else:
		#print(name, " is INactive.")
		#Decrease temp
		Events.SunStateChangeSignal.emit(self, 0 - temp_change_amount)

func _toggle_state():
	active = not active
	set_state()
	
func set_path_position():
	var r_remain = inverse_lerp(timer.wait_time, 0, timer.time_left)
	var p : PathFollow2D = get_parent()
	p.progress_ratio = r_remain
