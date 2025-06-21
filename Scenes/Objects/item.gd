extends Area2D
class_name item

signal received_item

var direction: Vector2 = Vector2.RIGHT
var distance: int = randi_range(10, 20)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "position", target_pos, 0.3)
	tween.tween_property(self, "scale", Vector2(1,1), 0.2).from(Vector2(0,0))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Globals.inventory["wood"] += 1
	received_item.emit()
	queue_free()
