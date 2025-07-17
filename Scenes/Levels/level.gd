extends Node2D
class_name Level

var near_obj = null
var item_scn = preload("res://scenes/Objects/item.tscn")

var wood = preload("res://Graphics/Elements/Crops/wood.png")
var sunflower = preload("res://Graphics/Elements/Crops/sunflower_05.png")
var pumpkin = preload("res://Graphics/Elements/Crops/pumpkin_05.png")
var wheat = preload("res://Graphics/Elements/Crops/wheat_05.png")
@onready var hourTimer = $HourTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for player in $ysort.get_children():
		player.connect("player_performed_action", _on_player_player_performed_action)
	for tree in $ysort/trees.get_children():
		# from tree
		tree.connect("player_near", _on_player_near_tree)
		tree.connect("player_not_near", _on_player_not_near_tree)
		tree.connect("chopped", _on_tree_chopped)
		# from player
		#tree.connect("player_performed_action", _on_player_player_performed_action)
	for soil in $ysort/soil.get_children():
		soil.connect("player_near", _on_player_near_soil)
		soil.connect("player_not_near", _on_player_not_near_soil)
		soil.connect("harvested", _on_crop_harvested)
	$HourTimer.connect("timeout", _on_hour_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if near_obj != null and near_obj.has_method("show_indicators"):
		near_obj.show_indicators()
	if near_obj != null and near_obj.get("can_harvest"):
		if near_obj.can_harvest:
			Globals.env_type = Globals.harvest
	

func _on_player_near_tree(tree: Node2D):
	near_obj = tree
	Globals.env_type = Globals.tree
	
func _on_player_not_near_tree(tree: Node2D):
	near_obj = null
	Globals.env_type = ""

func _on_player_player_performed_action() -> void:
	near_obj.perform_action()
	
func _on_player_near_soil(soil: Node2D):
	if near_obj != null and near_obj.has_method("hide_indicators"):
		near_obj.hide_indicators()
	near_obj = soil
	if soil.can_grow_seed:
		Globals.env_type = Globals.soil
	else:
		Globals.env_type = Globals.crop
	
func _on_player_not_near_soil(soil: Node2D):
	soil.hide_indicators()
	if near_obj == soil:
		near_obj = null
		Globals.env_type = ""
	
func _on_tree_chopped(pos, direction):
	for i in range(3):
		var chopped_wood = item_scn.instantiate()
		chopped_wood.position = pos + direction * 10
		chopped_wood.get_child(0).texture = wood
		$items.call_deferred("add_child",chopped_wood)
func _on_crop_harvested(pos, direction, crop_type):
	for i in range(3):
		var harvest = item_scn.instantiate()
		harvest.position = pos + direction * 10
		if crop_type == "sunflower":
			harvest.get_child(0).texture = sunflower 
		elif crop_type == "pumpkin":
			harvest.get_child(0).texture = pumpkin
		elif crop_type == "wheat":
			harvest.get_child(0).texture = wheat
		
		$items.call_deferred("add_child",harvest)



func _on_hour_timer_timeout() -> void:
	Globals.hour += 1
	hourTimer.start()
