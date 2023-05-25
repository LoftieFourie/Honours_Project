extends RigidBody2D

var velocity = Vector2.ZERO
@export var speed = 200

var target = position

func _physics_process(delta):
	var spawnlocation : Vector2 = position.direction_to(get_global_mouse_position())
	var spawn_distance : int = 10
	velocity = position.direction_to(get_global_mouse_position()) * speed
	look_at(get_global_mouse_position())
	set_axis_velocity(velocity)
	
	await get_tree().create_timer(2.0).timeout
	queue_free()
