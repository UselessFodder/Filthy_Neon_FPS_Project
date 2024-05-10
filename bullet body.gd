extends RigidBody3D

const SPEED = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var forward : Vector3 = global_transform.basis.z
	#apply_impulse(forward * -SPEED)
	
	#apply_impulse(transform.basis.z * -SPEED)
	#print("Bullet direction: %s" % (transform.basis.z.normalized() * -SPEED))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	pass

func push_bullet(direction):
	apply_impulse(direction * -SPEED)
	print("Bullet direction: %s" % (transform.basis.z.normalized() * -SPEED))
