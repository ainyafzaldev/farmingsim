extends Crop

@onready var thirsty_color = Color("a89583")
@onready var needs_water:bool = true
@onready var growthAnimationPLayer = $growthAnimation
@onready var can_harvest = false

func _ready() -> void:
	growthAnimationPLayer.current_animation = "seed"
	
	set_grow_time()
	set_water_time()
	
	$grow.connect("timeout", _on_grow_timeout)
	$water.connect("timeout", _on_water_timeout)
	
	$ysorting/plant.modulate = thirsty_color


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
		can_harvest = true

func perform_action():
	water_crop()
	
func water_crop():
	if needs_water:
		needs_water = false
		await get_tree().create_timer(0.3).timeout
		print("watered")
		$ysorting/plant.modulate = Color("ffffff")
		if $grow.paused:
			$grow.paused = false
		else:
			$grow.start()
		$water.start()

func _on_grow_timeout() -> void:
	stage += 1
	# received by soil
	plant_stage.emit(stage)
	if not can_harvest:
		$grow.start()
	else:
		Globals.env_type = Globals.harvest
		
func _on_water_timeout() -> void:
	if not can_harvest:
		# pause growing
		$grow.paused = true
		$ysorting/plant.modulate = thirsty_color
		needs_water = true
func set_grow_time():
	var type = $ysorting/plant.get_meta("type")
	if type == "sunflower":
		$grow.wait_time = 1.0
	elif type == "pumpkin":
		$grow.wait_time = 5.0
	elif type == "wheat":
		$grow.wait_time = 2.0
	else:
		print("error: no grow timer in "+ type)

func set_water_time():
	var type = $ysorting/plant.get_meta("type")
	if type == "sunflower":
		$water.wait_time = 6.0
	elif type == "pumpkin":
		$water.wait_time = 4.0
	elif type == "wheat":
		$water.wait_time = 5.0
	else:
		print("error: no plant timer in " + type)
