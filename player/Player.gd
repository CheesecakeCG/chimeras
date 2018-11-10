extends "res://assets/simple_fpsplayer/Player.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var jump_force

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		translate(Vector3(0, jump_force, 0))
