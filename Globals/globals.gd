extends Node
# tools
const wateringCan: String = "watering can"
const shovel: String = "shovel"
const axe: String = "axe"

#movements
const idle:String = "idle"
const walk:String = "walk"
const run:String = "run"
const jump:String = "jump"
const roll:String = "roll"
const action:String = "action"
const busy:String = "busy"

var action_speed:int = 0
var walking_speed:int = 40
var running_speed:int = 70

var active_tool:String = wateringCan

var movement_type: String = idle

# if active_tool matches what player is near
var can_do_action: bool = false
var is_doing_action: bool = false

var inventory = {"wood": 0, "sunflower": 0, "pumpkin": 0}
