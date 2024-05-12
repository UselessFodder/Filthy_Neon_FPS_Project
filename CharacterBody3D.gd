extends CharacterBody3D

@onready var head = $Head
@onready var feet = $Feet
@onready var weapon_pos = $Head/weapon_pos


const FEET_HEIGHT = 0.0

const STAND_HEIGHT = 0.5
const CROUCH_HEIGHT = STAND_HEIGHT * 0.5

const SPEED = 5.0

var current_speed = SPEED
var run_speed = SPEED * 3
var crouch_speed = SPEED * 0.25

const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	var weapon = preload("res://weapon.tscn")
	var current_weapon = weapon.instantiate()
	current_weapon.transform = weapon_pos.transform
	weapon_pos.add_child(current_weapon)
	

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENS))
		head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENS))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Check for sprint or crouch
	if Input.is_action_pressed("sprint") and is_on_floor():
		current_speed = run_speed
	elif Input.is_action_pressed("crouch") and is_on_floor():
		current_speed = crouch_speed
	else:
		current_speed = SPEED
	
	if Input.is_action_pressed("crouch"):
		head.position.y = CROUCH_HEIGHT
		if !is_on_floor():
			feet.position.y = FEET_HEIGHT + 0.5
	else:
		head.position.y = STAND_HEIGHT
		feet.position.y = FEET_HEIGHT
		
	# Check for shooting
	if Input.is_action_just_pressed("primary fire"):

		var current_weapon = weapon_pos.get_child(0)
		var origin = head.global_transform
		current_weapon.shoot(origin)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
	
#func shoot():
#	var bullet = preload("res://bullet.tscn")
#	var new_bullet = bullet.instantiate()
#	get_parent().add_child(new_bullet)
#	print("Bullet added successfully")
#
#
#	# Set the bullet's position
#	new_bullet.global_transform.origin = head.global_transform.origin + head.global_transform.basis.z.normalized() * -1
#
#	# Set bullet's rotation to match the head's
#
#	#new_bullet.get_child(0).apply_impulse(transform.basis.z * -SPEED)
#	new_bullet.get_child(0).push_bullet(transform.basis.z)
#	new_bullet.global_transform.basis.z = head.global_transform.basis.z
