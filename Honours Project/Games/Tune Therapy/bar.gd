extends RigidBody2D

var animation_player: AnimationPlayer

func _ready():
	animation_player = $AnimationPlayer
	
func _process(delta):
	pass


func dequeue_item():
	animation_player.play("pop")
	await get_tree().create_timer(0.15).timeout
	queue_free()
