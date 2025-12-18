extends Node2D
signal player_near(soil)
signal player_not_near(soil)
signal harvested(pos, direction, type)

var can_grow_seed: bool = true
var can_harvest: bool = false
var current_direction: Vector2 = Vector2.RIGHT.rotated(rotation) # down because it is the default direction of the items
var sunflower_scene = preload("res://Scenes/Objects/sunflower.tscn")
var pumpkin_scene = preload("res://Scenes/Objects/pumpkin.tscn")
var wheat_scene = preload("res://Scenes/Objects/wheat.tscn")
const max_stage = 4
var crop_type = null
var crop = null
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
		
	if stage == max_stage:
		can_harvest = true

func perform_action():
	if Globals.env_type == Globals.soil:
		plant_seed()
	elif Globals.env_type == Globals.crop:
		crop.perform_action()
	elif Globals.env_type == Globals.harvest:
		harvest_crop()
	
func plant_seed():
	if not can_grow_seed:
		return
	print("soil action")
	can_grow_seed = false
	Globals.env_type = Globals.crop
	await get_tree().create_timer(1.0).timeout
	print(Globals.holding)
	if Globals.holding == Globals.sunflower_seed:
		crop = sunflower_scene.instantiate()
		crop_type = "sunflower"
	elif Globals.holding == Globals.pumpkin_seed:
		crop = pumpkin_scene.instantiate()
		crop_type = "pumpkin"
	elif Globals.holding == Globals.wheat_seed:
		crop = wheat_scene.instantiate()
		crop_type = "wheat"
	else:
		return
	Globals.inventory[Globals.holding] -= 1
	crop.position = $growPoint.position
	#crop.direction = current_direction
	crop.connect("plant_stage", _on_crop_plant_stage)
	$plant.call_deferred("add_child",crop)
func harvest_crop():
	if can_harvest:
		print("shake")
		await get_tree().create_timer(1.0).timeout
		# received by level
		harvested.emit($spawnPoint.global_position, current_direction, crop_type)
		crop.queue_free()
		$soilAnimation.current_animation = "soilDry"
		can_grow_seed = true
		can_harvest = false
		
func show_indicators():
	$indicators.visible = true
func hide_indicators():
	$indicators.visible = false


func _on_near_soil_area_entered(area: Area2D) -> void:
	if area.get_owner() is Player:
		# received by level
		player_near.emit(self)


func _on_near_soil_area_exited(area: Area2D) -> void:
	if area.get_owner() is Player:
		# received by level
		player_not_near.emit(self)
