extends Node2D
class_name Crop

signal plant_stage(stage, type)

var needs_water:bool = true

var stage:int = 0 # up to 4
const max_stage = 4

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func perform_action():
	await get_tree().create_timer(0.5).timeout
	print("water")
	modulate = Color("ca8d78")
	await get_tree().create_timer(0.6).timeout
	modulate = Color("ffffff")

func _on_grow_timeout() -> void:
	stage += 1
	plant_stage.emit(stage)
	if stage < max_stage:
		$grow.start()
