extends Node2D

var dialogue_resource: DialogueResource

var Temp = 0

func _ready():
	Events.SunStateChangeSignal.connect(_temp_change)	
	#Triggers any nodes which need to set up and have been waiting
	Events.MainIsReadySignal.emit()

func start_my_dialogue(file_in):
	DialogueManager.show_dialogue_balloon(dialogue_resource, file_in)

func _temp_change(_obj, change: float):
	Temp = Temp + change
	Events.TempChangeSignal.emit(Temp)
