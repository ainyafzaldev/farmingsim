extends Node2D
signal player_near(tree)
signal player_not_near(tree)

signal chopped(pos, direction)

@onready var current_direction: Vector2 = Vector2.RIGHT.rotated(rotation) # down because it is the default direction of the items
var hit_count = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func perform_action():
	await get_tree().create_timer(0.5).timeout
	print("shakeshake")
	modulate = Color("ca8d78")
	await get_tree().create_timer(0.6).timeout
	modulate = Color("ffffff")
	hit_count -= 1
	
	if hit_count == 0:
		chopped.emit($Node2D/spawnPoint.global_position, current_direction)
		queue_free()
		

func _on_cut_area_area_entered(area: Area2D) -> void:
	player_near.emit(self)


func _on_cut_area_area_exited(area: Area2D) -> void:
	player_not_near.emit(self)
