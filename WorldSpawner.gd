extends Node2D

@export var numSpawnLocations: int = 0
@export var paddingMinMax: Vector2
@export var locationsResource: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO check for save load
	_place_locations()
	
func _place_locations():
	
	var size = get_viewport_rect().size
	position.x = size.x/2
	
	var startLoc = locationsResource.start_location.instantiate()
	add_child(startLoc)
	
	for i in numSpawnLocations:
		var loc = locationsResource.locations[randi() % locationsResource.locations.size()]
		var newLocation = loc.instantiate()
		add_child(newLocation)
		if i < numSpawnLocations/2:
			var xPos = (i * paddingMinMax.y) + randi_range(paddingMinMax.x, paddingMinMax.y)
			newLocation.position.x = 0 - xPos
		else:
			var xPos = ((i - (numSpawnLocations/2)) * paddingMinMax.y) + randi_range(paddingMinMax.x, paddingMinMax.y)
			newLocation.position.x = xPos
