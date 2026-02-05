extends Node2D

var active = false
var canBegin = false
var timer = 0
var timerLimit = 50
@onready var sprite = $Sprite2D
@onready var area = $Sprite2D/Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if sprite.texture == null:
		return
	var spriteTextSize = sprite.texture.get_size()
	position.y = 0 - (spriteTextSize.y/2)
	area.scale.x = (spriteTextSize.y/2)/10
	area.scale.y = area.scale.x

func _process(_delta):
	if Input.is_action_just_pressed("DoAction") and active:
		canBegin = true
	if Input.is_action_pressed("DoAction") and canBegin:
		timer+=1
		if timer == timerLimit:
			_action()
			timer = 0
	if Input.is_action_just_released("DoAction") and active:
		timer = 0
		
func _action():
	#Can I somehow use resources to connect unique functions here? 
	sprite.flip_h = !sprite.flip_h
	print("Do action on this location.")

func _on_area_2d_body_entered(_body):
	active = true
	
func _on_area_2d_body_exited(_body):
	_reset()
	
func _reset():
	timer = 0
	active = false
	canBegin = false
