extends TextureRect

@export var BLUE_TINT : Color
@export var YELLOW_TINT : Color
@export var WHITE_TINT : Color
@export var NIGHT_TINT : Color

var blue_active := false
var yellow_active := false

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.SunStateChangeSignal.connect(sun_changed)

func sun_changed(obj, amount):
	print("Sun changed ", obj.name)
	var active : bool = amount > 0
	if obj.name == "YellowSun":
		yellow_active = active
	elif obj.name == "BlueSun":
		blue_active = active
		
	set_tint_color()

func set_tint_color():
	if blue_active == true and yellow_active == false:
		modulate = BLUE_TINT
	elif blue_active == false and yellow_active == true:
		modulate = YELLOW_TINT
	elif blue_active == true and yellow_active == true:
		modulate = WHITE_TINT
	else:
		modulate = NIGHT_TINT
