extends Control

@onready var item_image: TextureRect = $item
@onready var count_label: Label = $countLabel
@onready var indicators = $boxSelector

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func indicators_off():
	indicators.visible = false
	
func indicators_on():
	indicators.visible = true
	
func update_count(count: String):
	count_label.text = count
	
#func set_item_image(item_name: String):
	#if item_name == "wood":
		#item_image.texture.resource_path = "res://Graphics/Elements/Crops/wood.png"

func update(item: InvItem):
	if !item:
		item_image.visible =  false
	else:
		item_image.visible = true
		item_image.texture = item.texture
