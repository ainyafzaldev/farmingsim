extends CanvasLayer

@onready var inv: Inv = preload("res://Inventory/player_inv.tres")
@onready var slots: Array = $GridContainer.get_children()
var is_open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_slots()
	close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inv"):
		if is_open:
			close()
		else:
			open()
func update_slots():
	for i in range(min(inv.item.size(), slots.size())):
		slots[i].update(inv.item[i])
	
func open():
	self.visible = true
	is_open = true
	
func close():
	self.visible = false
	is_open = false
