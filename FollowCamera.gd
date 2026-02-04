extends Node2D

var player
var offsetX
var offsetY
@export var useY: bool = false

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
	offsetX = position.x - player.position.x
	offsetY = position.y - player.position.y

func _process(delta):
	position.x = player.position.x + offsetX
	if useY:
		position.y = player.position.y + offsetY
