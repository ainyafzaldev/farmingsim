extends Node2D
signal player_near(tree)
signal player_not_near(tree)

var hit_count = 3


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
		queue_free()
		


func _on_cut_area_body_entered(body: Node2D) -> void:
	player_near.emit(self)


func _on_cut_area_body_exited(body: Node2D) -> void:
	player_not_near.emit(self)
