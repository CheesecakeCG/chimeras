extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var jump_force = 5000
export var walk_force = 200
export var weight = 2
export var term_vel = 40
var vel = Vector3()
var dir = Vector3()
var mouse_sensitivity = 1

onready var body = $Body
onready var cam = $Body/Camera
# Called when the node enters the scene tree for the first time.
func _ready():
	jump_force /= weight
	walk_force /= weight
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_key_pressed(KEY_W):
		vel.z += walk_force * delta
	if Input.is_key_pressed(KEY_S):
		vel.z -= walk_force * delta
	if Input.is_key_pressed(KEY_A):
		vel.x += walk_force * delta
	if Input.is_key_pressed(KEY_D):
		vel.x -= walk_force * delta
	
	# Friction
	if not (Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_W)):
		var temp_vel = vel - vel.normalized() * weight 
		vel.x = temp_vel.x
		vel.z = temp_vel.z
	# Gravity
	if not is_on_floor():
		vel.y -= 9.81 * delta
		print("AHHHHH")
	else:
		vel.y = 0;
	#Terminal Velocity
	vel.x = clamp(vel.x, -term_vel, term_vel)
	vel.y = clamp(vel.y, -term_vel, term_vel)
	vel.z = clamp(vel.z, -term_vel, term_vel)
	
	move_and_slide(vel.rotated(body.transform.basis.y, body.rotation.y), Vector3(0, 1, 0))
	
func _process(delta):
	cam.rotation_degrees.x = dir.x
	body.rotation_degrees.y = dir.y
	
func _input(event):
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		vel += Vector3(0, jump_force, 0)
	
	if event is InputEventMouseMotion:
		dir.y += -event.relative.x * mouse_sensitivity * .1
		dir.x = clamp(dir.x + -event.relative.y * mouse_sensitivity * .1, -70, 85)

	
