extends CanvasLayer

@onready var dayCountLabel = $timeDisplay/dayCount
@onready var hourCountLabel = $timeDisplay/hourCount

# 0 axe
# 1 watering can
# 2 shovel
var selected_tool = 0

# toolbox node heirarchy
# - Toolbox HBox
# - - boxX cNode
# - - - boxTexture cNode
# - - - itemX TextureRect
# - - - count cNode
# - - - boxSelector cNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect("time_change", on_time_change)
	
	update_tool_slector()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not Globals.is_doing_action:
		update_toolbar_scroll()
	update_tool_slector()
func update_toolbar_scroll():
	if Input.is_action_just_released("scroll up"):
		selected_tool = (selected_tool + 1) % 8
		
	if Input.is_action_just_released("scroll down"):
		selected_tool = (selected_tool - 1) % 8
		if selected_tool == -1:
			selected_tool = 7
		else:
			selected_tool = abs(selected_tool)
	Globals.toolbar_selection = selected_tool
func update_tool_slector():
	all_indicators_off()
	load_tools()
func all_indicators_off():
	$Toolbox/box1/boxSelector.visible = false
	$Toolbox/box2/boxSelector.visible = false
	$Toolbox/box3/boxSelector.visible = false
	$Toolbox/box4/boxSelector.visible = false
	$Toolbox/box5/boxSelector.visible = false
	$Toolbox/box6/boxSelector.visible = false
	$Toolbox/box7/boxSelector.visible = false
	$Toolbox/box8/boxSelector.visible = false
	
func load_tools():
	for box_num in range(8):

		var box = $Toolbox.get_child(box_num)
		var item: TextureRect = box.get_child(1)
		if item.texture != null: 
			update_toolbox_count(box, item)
		else:
			box.get_child(2).visible = false
		if box_num == Globals.toolbar_selection:
			box.get_child(3).visible = true
			if item.texture != null:
				check_for_tool(item)
				
		
func check_for_tool(item: TextureRect):
	if item.texture.resource_path.contains("axe"):
		Globals.active_tool = Globals.axe
	elif item.texture.resource_path.contains("water"):
		Globals.active_tool = Globals.wateringCan
	elif item.texture.resource_path.contains("shovel"):
		Globals.active_tool = Globals.shovel
	elif item.texture.resource_path.contains("_00"):
		Globals.active_tool = Globals.seed
		find_holding_seed(item)
		
func find_holding_seed(item: TextureRect):
	# update tol include all ojects, or find a better way to assign like string parsing
	if item.texture.resource_path.contains(Globals.sunflower_seed):
		Globals.holding = Globals.sunflower_seed
	elif item.texture.resource_path.contains(Globals.pumpkin_seed):
		Globals.holding = Globals.pumpkin_seed
	elif item.texture.resource_path.contains(Globals.wheat_seed):
		Globals.holding = Globals.wheat_seed
	
func is_tool(item):
	return item.texture.resource_path.contains("axe") or item.texture.resource_path.contains("water") or item.texture.resource_path.contains("shovel")



func update_toolbox_count(box :Control, item: TextureRect) -> void:
	
	var count:Control = box.get_child(2)
	if is_tool(item):
		count.visible = false
	else:
		count.visible = true
		
	# update ui based on inventory globals
	for inventoryItem in Globals.inventory:
		if item.texture.resource_path.contains(inventoryItem):
			var label:Label = count.get_child(-1)
			label.text = str(Globals.inventory[inventoryItem])
			break

	
func update_day_count():
	dayCountLabel.text = str(Globals.day)
	
func update_hour_count():
	if Globals.hour < 13:
		hourCountLabel.text = str(Globals.hour) + " am"
	else:
		hourCountLabel.text = str(Globals.hour%13 + 1) + " pm"
		
func on_time_change():
	update_day_count()
	update_hour_count()
