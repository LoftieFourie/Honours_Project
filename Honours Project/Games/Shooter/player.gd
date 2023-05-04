extends Area2D

var bullet = preload("res://bullet.tscn")

@export var speed = 200


var target = position
var velocity = Vector2.ZERO

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	shooting()
	look_at(get_global_mouse_position())
	
	
func shooting():
	var isshooting = true
	var bulletinstance = bullet.instantiate()
	var spawnlocation : Vector2 = position.direction_to(get_global_mouse_position())
	var spawn_distance : int = 10
	
	if Input.is_action_pressed("shoot"):
		print(spawnlocation)
		target = get_global_mouse_position()
		get_tree().get_root().add_child(bulletinstance)
		velocity = position.direction_to(target) * speed
		bulletinstance.position = Vector2(position)
		
		
func _on_area_entered(area):
	print("hit")
