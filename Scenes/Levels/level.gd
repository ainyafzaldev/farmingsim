extends Node2D
class_name Level

var near_obj = null
var wood_item = preload("res://scenes/Objects/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("hi")
	for tree in $ysorted/trees.get_children():
		# from tree
		tree.connect("player_near", _on_player_near_tree)
		tree.connect("player_not_near", _on_player_not_near_tree)
		tree.connect("chopped", _on_tree_chopped)
		# from player
		#tree.connect("player_performed_action", _on_player_player_performed_action)
	for crop in $ysorted/crop.get_children():
		crop.connect("player_near", _on_player_near_crop)
		crop.connect("player_not_near", _on_player_not_near_crop)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_player_near_tree(tree: Node2D):
	print("player near tree")
	near_obj = tree
	if Globals.active_tool == Globals.axe:
		Globals.can_do_action = true
	
func _on_player_not_near_tree(tree: Node2D):
	print("player not near tree")
	near_obj = null
	Globals.can_do_action = false

func _on_player_player_performed_action() -> void:
	near_obj.perform_action()
	
func _on_player_near_crop(crop: Node2D):
	print("player near crop")
	if near_obj != null and near_obj.has_method("hide_indicators"):
		near_obj.hide_indicators()
	near_obj = crop
	crop.show_indicators()
	if Globals.active_tool == Globals.wateringCan:
		Globals.can_do_action = true
	
func _on_player_not_near_crop(crop: Node2D):
	print("player not near crop")
	near_obj = null
	crop.hide_indicators()
	Globals.can_do_action = false
	
func _on_tree_chopped(pos, direction):
	for i in range(3):
		var item = wood_item.instantiate()
		item.position = pos + direction * 10
	
		item.connect("received_item", _on_item_received)
		$items.call_deferred("add_child",item)
func _on_item_received():
	$UI.update_wood_count()
