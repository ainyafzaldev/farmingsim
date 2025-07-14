extends Node2D
class_name Level

var near_obj = null
var wood_item = preload("res://scenes/Objects/item.tscn")

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
		soil.connect("planted_seed", _on_player_planted_seed)
	$HourTimer.connect("timeout", _on_hour_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if near_obj != null and near_obj.has_method("show_indicators"):
		near_obj.show_indicators()

func _on_player_near_tree(tree: Node2D):
	print("player near tree")
	near_obj = tree
	Globals.env_type = Globals.tree
	
func _on_player_not_near_tree(tree: Node2D):
	print("player not near tree")
	near_obj = null
	Globals.env_type = ""

func _on_player_player_performed_action() -> void:
	near_obj.perform_action()
	
func _on_player_near_soil(soil: Node2D):
	print("player near soil")
	if near_obj != null and near_obj.has_method("hide_indicators"):
		near_obj.hide_indicators()
	near_obj = soil
	Globals.env_type = Globals.soil
	
	
func _on_player_not_near_soil(soil: Node2D):
	print("player not near soil")
	soil.hide_indicators()
	if near_obj == soil:
		near_obj = null
		Globals.env_type = ""
	
func _on_tree_chopped(pos, direction):
	for i in range(3):
		var item = wood_item.instantiate()
		item.position = pos + direction * 10
	
		item.connect("received_item", _on_item_received)
		$items.call_deferred("add_child",item)
func _on_player_planted_seed():
	pass
func _on_item_received(item):
	print(item)


func _on_hour_timer_timeout() -> void:
	Globals.hour += 1
	hourTimer.start()
