extends CanvasLayer

@onready var woodCountLabel = $wood/label
@onready var sunflowerCountLabel = $sunflower/label

# 0 axe
# 1 watering can
# 2 shovel
var selected_tool = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%wateringCanSelector.visible = false
	%axeSelector.visible = false
	%shovelSelector.visible = false
	if Globals.active_tool == Globals.wateringCan:
		%wateringCanSelector.visible = true
		selected_tool = 1
	elif Globals.active_tool == Globals.axe:
		%axeSelector.visible = true
		selected_tool = 0
	elif Globals.active_tool == Globals.shovel:
		%shovelSelector.visible = true
		selected_tool = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("scroll up"):
		selected_tool = (selected_tool - 1) % 3
		if selected_tool == -1:
			selected_tool = 2
		else:
			selected_tool = abs(selected_tool)
	if Input.is_action_just_released("scroll down"):
		selected_tool = (selected_tool + 1) % 3
	update_tool_slector()
		
func update_tool_slector():
	%wateringCanSelector.visible = false
	%axeSelector.visible = false
	%shovelSelector.visible = false
	if selected_tool == 0:
		%axeSelector.visible = true
		Globals.active_tool = Globals.axe
	if selected_tool == 1:
		%wateringCanSelector.visible = true
		Globals.active_tool == Globals.wateringCan
	if selected_tool == 2:
		%shovelSelector.visible = true
		Globals.active_tool == Globals.shovel
		
		
