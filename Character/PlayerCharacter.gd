extends CharacterBody2D

@export var WALK_SPEED := 300.0
@export var DASH_MUL := 2.0

@onready var sprite := %AnimatedSprite2D
var current_speed := 0.0
var is_crouched := false
var direction := 0.0
var crouch_mul := 1.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	add_to_group("Player")
	Events.TempChangeSignal.connect(_temp_changed)

func _temp_changed(new_temp):
	if new_temp < 10 or new_temp > 90:
		WALK_SPEED = 150
	else:
		WALK_SPEED = 300.0
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_pressed("Dash") and is_on_floor():
		current_speed = WALK_SPEED * DASH_MUL
	else:
		current_speed = WALK_SPEED

	if Input.is_action_pressed("Crouch"):
		is_crouched = true
		crouch_mul = clampf(crouch_mul - 0.025, 0, 1)
	elif Input.is_action_just_released("Crouch"):
		is_crouched = false
		crouch_mul = 1.0
	
	direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * current_speed * crouch_mul
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	set_animation()
	move_and_slide()
	
func set_animation():
	if is_crouched:
		sprite.play("crouch")
	elif velocity.x != 0:
		sprite.play("walk")
	else:
		sprite.play("walk")
		sprite.pause()

	if direction < 0.0:
		sprite.flip_h = true
	elif direction > 0.0:
		sprite.flip_h = false
