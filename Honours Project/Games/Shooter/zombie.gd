extends RigidBody2D

func _ready():
	$AnimatedSprite2D.play()
	
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _shot(body):
	print("hit")
	queue_free()
	$CollisionShape2D.set_deferred("disabled",true)
