extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/TempLabel.visible = true
	$VBoxContainer/OxyLabel.visible = false
	Events.TempChangeSignal.connect(_on_temp_change_signal)

func _on_temp_change_signal(temp):
	$VBoxContainer/TempLabel.set_text("Temperature: " + str(temp))
