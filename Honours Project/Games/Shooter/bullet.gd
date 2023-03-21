extends RigidBody2D

var velocity = Vector2.ZERO
@export var speed = 400

var target = position

func _physics_process(delta):
	var spawnlocation : Vector2 = position.direction_to(get_global_mouse_position())
	var spawn_distance : int = 10
	velocity = position.direction_to(target) * speed
	look_at(get_global_mouse_position())
	set_axis_velocity(Vector2(-(position) + spawnlocation*spawn_distance))
	
