extends Control

@onready var buttonNew = $NinePatchRect/VBoxContainer/New

# Called when the node enters the scene tree for the first time.
func _ready():
	buttonNew.pressed.connect(self._new_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _new_game():
	get_tree().change_scene_to_file("res://main_level.tscn")
