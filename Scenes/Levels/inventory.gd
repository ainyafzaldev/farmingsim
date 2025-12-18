extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func populate_boxes():
	var obj_index = 0
	var inventory = Globals.inventory
	inventory.sort()
	for obj in inventory:
		if Globals.inventory[obj] >0:
			break
		obj_index += 1
	for toolbox in $VBoxContainer:
		for box in toolbox:
			box.set_item_image("wood")
		
