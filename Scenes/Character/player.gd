extends CharacterBody2D
class_name Player
signal player_performed_action


@onready var speed = Globals.walking_speed

var facing_right:bool = true
var is_jumping:bool = false
var is_rolling:bool = false
#
#var in_crop1 = false
#var in_crop2 = false
#var in_crop3 = false
#
#var cut_tree = false
#var current_tree = null
#
#var do_action = false

func _process(_delta: float) -> void:
	if not Input.is_anything_pressed():
		Globals.movement_type = Globals.idle
	
	elif Globals.is_doing_action:
		# cannot move while performing action
		speed = Globals.action_speed
		is_jumping = false
		is_rolling = false
	else:
		# something was pressed
		
		# walk assumed
		speed = Globals.walking_speed
		if Input.is_action_pressed("right"):
			facing_right = true
			Globals.movement_type = Globals.walk
			
		if Input.is_action_pressed("left"):
			facing_right = false
			Globals.movement_type = Globals.walk
			
		if Input.is_action_pressed("up") or Input.is_action_pressed("down"):
			Globals.movement_type = Globals.walk
			
		# run on shift
		if Input.is_action_pressed("run"):
			speed = Globals.running_speed
			Globals.movement_type = Globals.run
			
		# jump and roll along with running / walking
		if Input.is_action_just_pressed("jump"):
			Globals.movement_type = Globals.jump
			is_jumping = true
			
		if Input.is_action_just_pressed("roll"):
			Globals.movement_type = Globals.roll
			is_rolling = true
			
		# pressed action - cannot move while performing action
		if Input.is_action_just_pressed("action")  and Globals.can_do_action:
			print("action")
			Globals.is_doing_action = true
			# received by level
			player_performed_action.emit()
			Globals.movement_type = Globals.action
			
		
	
	play_animation()
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	
func play_animation():
	if facing_right:
		$Animations/DirectionAnimation.play("right")
	else:
		# is it playing more than necessary?
		$Animations/DirectionAnimation.play("left")
	 
	# action, rolling and jumping need to go first since they are in addition to walking
	if Globals.movement_type == Globals.action or Globals.is_doing_action:
		if Globals.env_type == Globals.harvest:
			$Animations/ActionAnimations.play("doing")
		else:
			if Globals.active_tool == Globals.wateringCan:
				$Animations/ActionAnimations.play("watering")
			elif Globals.active_tool == Globals.shovel:
				$Animations/ActionAnimations.play("digging")
			elif Globals.active_tool == Globals.axe:
				$Animations/ActionAnimations.play("axing")
			elif Globals.active_tool == Globals.seed:
				$Animations/ActionAnimations.play("doing")
			
	elif Globals.movement_type == Globals.roll or is_rolling:
		$Animations/ActionAnimations.play("rolling")
	elif Globals.movement_type == Globals.jump or is_jumping:
		$Animations/ActionAnimations.play("jumping")
	elif Globals.movement_type == Globals.walk:
		$Animations/ActionAnimations.play("walking")
	elif Globals.movement_type == Globals.run:
		$Animations/ActionAnimations.play("running")
	elif Globals.movement_type == Globals.idle:
		$Animations/ActionAnimations.play("idle")

		
#
func _on_action_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "jumping":
		is_jumping = false
	if anim_name == "rolling":
		is_rolling = false
	if anim_name == "watering":
		Globals.is_doing_action = false 
	if anim_name == "digging":
		Globals.is_doing_action = false
	if anim_name == "axing":
		Globals.is_doing_action = false
	if anim_name == "doing":
		Globals.is_doing_action = false
		
