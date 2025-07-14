extends Node2D
signal player_near(soil)
signal player_not_near(soil)

signal planted_seed

var can_grow_seed: bool = true
var current_direction: Vector2 = Vector2.RIGHT.rotated(rotation) # down because it is the default direction of the items
var sunflower_scene = preload("res://Scenes/Objects/sunflower.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_crop_plant_stage(stage) -> void:
	
	if stage == 1:
		$soilAnimation.current_animation = "soilSmallHole"
	elif stage == 2:
		$soilAnimation.current_animation = "soilSmallHole"
	elif stage == 3:
		$soilAnimation.current_animation = "soilBigHole"
	elif stage == 4:
		$soilAnimation.current_animation = "soilBigHole"

func perform_action():
	print("soil action")
	can_grow_seed = false
	planted_seed.emit()
	await get_tree().create_timer(1.0).timeout
	var crop = sunflower_scene.instantiate()
	crop.position = $growPoint.position
	#crop.direction = current_direction
	$plant.call_deferred("add_child",crop)

func show_indicators():
	$indicators.visible = true
func hide_indicators():
	$indicators.visible = false
	


#func _on_near_soil_body_entered(body: Node2D) -> void:
	#player_near.emit(self)
	#
#func _on_near_soil_body_exited(body: Node2D) -> void:
	#player_not_near.emit(self)


func _on_near_soil_area_entered(area: Area2D) -> void:
	if area.get_owner() is Player:
		print("soil player near")
		player_near.emit(self)


func _on_near_soil_area_exited(area: Area2D) -> void:
	player_not_near.emit(self)
