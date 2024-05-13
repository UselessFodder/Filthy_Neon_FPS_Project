class_name Weapon extends Node3D

@export var is_automatic = true
const SPEED = 20
const RATE_OF_FIRE = 120.0

var ready_to_fire = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(transform):
	if ready_to_fire:
		ready_to_fire = false
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

		#create a new timer to wait 
		var shot_wait = snappedf(60.0/RATE_OF_FIRE,0.01)
		print("shot_wait = %s" % shot_wait)
		await get_tree().create_timer(shot_wait).timeout
		ready_to_fire = true
#		var timer := Timer.new()
#		add_child(timer)
#		timer.wait_time = 60/RATE_OF_FIRE
#		timer.one_shot
#		timer.start()
#		timer.connect("timeout",self,"on_timer_timeout")
		
func _on_timer_timer():
	ready_to_fire = true
