class_name Weapon extends Node3D

@export var is_automatic = false
const SPEED = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(transform):
	var bullet = preload("res://bullet.tscn")
	var new_bullet = bullet.instantiate()
	#get_parent().add_child(new_bullet)
	get_tree().root.add_child(new_bullet)
	print("Bullet added successfully")


	# Set the bullet's position
	new_bullet.global_transform.origin = transform.origin + transform.basis.z.normalized() * -1

	# Set bullet's rotation to match the head's
	
	#new_bullet.get_child(0).apply_impulse(transform.basis.z * -SPEED)
	new_bullet.get_child(0).apply_impulse(transform.basis.z * -SPEED)
	print("Bullet direction: %s" % (transform.basis.z.normalized() * -SPEED))
	
	#new_bullet.get_child(0).push_bullet(transform.basis.z)
	new_bullet.global_transform.basis.z = transform.basis.z
