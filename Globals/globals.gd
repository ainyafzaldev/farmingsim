extends Node

signal time_change
# tools
const wateringCan: String = "watering can"
const shovel: String = "shovel"
const axe: String = "axe"
const seed: String = "seed"

#movements
const idle:String = "idle"
const walk:String = "walk"
const run:String = "run"
const jump:String = "jump"
const roll:String = "roll"
const action:String = "action"
const busy:String = "busy"

# environents
const tree: String = "tree"
# before shovel
const ground: String = "ground"
# shoveled ground, no seed
const soil: String = "soil"
# soil with active plant in it
const crop: String = "crop"
const harvest: String = "harvest"


# crops
const sunflower_seed: String = "sunflower_00"
const pumpkin_seed: String = "pumpkin_00"
const wheat_seed: String = "wheat_00"

# there are 24 hours in a day, each hour lasts 1 min
var hour: int = 10: # hour is in military format - 0 to 24
	get: return hour
	set(val):
		if val > 24:
			val = 1
			day += 1
		else:
			hour = val
		time_change.emit()

# simple count of days
var day: int = 1


var action_speed:int = 0
var walking_speed:int = 40
var running_speed:int = 70

var active_tool:String = axe:
	set(tool):
		active_tool = tool
		check_can_do_action()
var env_type: String = "":
	set(env):
		env_type = env
		check_can_do_action()
func check_can_do_action():
	if active_tool == axe and env_type == tree:
			can_do_action = true
	elif active_tool == wateringCan and env_type == crop:
		can_do_action = true
	elif active_tool == shovel and env_type == ground:
		can_do_action = true
	elif active_tool == seed and env_type == soil:
		can_do_action = true
	elif env_type == harvest:
		can_do_action = true
	else:
		can_do_action = false
var movement_type: String = idle


# if active_tool matches what player is near
var can_do_action: bool = false
var is_doing_action: bool = false

var inventory = {"wood": 0, 
				"sunflower_05": 0, "pumpkin_05": 0, "wheat_05": 0,
				"sunflower_00": 10, "pumpkin_00": 10, "wheat_00": 10}

var toolbar_selection = 0:
	set(num):
		toolbar_selection = num
		if Globals.active_tool == Globals.wateringCan:
			Globals.can_do_action = true
# set when holding not tool object in toolbar
var holding = null
