extends Crop

@onready var growthAnimationPLayer = $growthAnimation
func _ready() -> void:
	growthAnimationPLayer.current_animation = "seed"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if stage == 1:
		growthAnimationPLayer.current_animation = "seedling1"
	elif stage == 2:
		growthAnimationPLayer.current_animation = "seedling2"
	elif stage == 3:
		growthAnimationPLayer.current_animation = "seedling3"
	elif stage == 4:
		growthAnimationPLayer.current_animation = "harvest"
