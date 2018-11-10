extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var last_mouse_pos = Vector2()
var viewport_rect
var viewport_center
var curr_delta = 0;

# Called when the node enters the scene tree for the first time.
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	update_view_rect()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	curr_delta = delta

func _input(event):
	var mouse_diff = get_viewport().get_mouse_position() - viewport_center
	var sens_mult = (1 * 360 * curr_delta)
	print(mouse_diff)

	$Camera.rotate_y( deg2rad(-mouse_diff.x / viewport_rect.x * sens_mult) )
#	$Camera.rotate_x( deg2rad(mouse_diff.y / viewport_rect.y * sens_mult) )

	$Camera.rotation_degrees.x = $Camera.rotation_degrees.x + -mouse_diff.y / viewport_rect.y * sens_mult
	$Camera.rotation_degrees.y = clamp($Camera.rotation_degrees.y + -mouse_diff.x / viewport_rect.x * sens_mult, -70, 89)
	$Camera.rotation_degrees.z = 0

	last_mouse_pos = get_viewport().get_mouse_position()
	Input.warp_mouse_position(viewport_center)

func update_view_rect():
	viewport_rect = get_viewport().size
	viewport_center = Vector2(viewport_rect.x/2, viewport_rect.y/2)
