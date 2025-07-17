extends Node2D
class_name Crop

signal plant_stage(stage)

var stage:int = 0 # up to 4
const max_stage = 4


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func perform_action():
	pass
