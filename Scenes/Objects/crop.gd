extends Node2D
class_name Crop

signal player_near(crop)
signal player_not_near(crop)

var needs_water:bool = true

var stage:int = 0 # up to 5


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
	
func show_indicators():
	$indicators.visible = true
func hide_indicators():
	$indicators.visible = false


func _on_near_crop_area_entered(area: Area2D) -> void:
	player_near.emit(self)


func _on_near_crop_area_exited(area: Area2D) -> void:
	player_not_near.emit(self)
	
