extends RigidBody2D

var speed = 100  # Adjust the falling speed as needed

var target_position: Vector2

func _ready():
	target_position = Vector2(randi(), 0)  # Set the starting position at the top
	
func _process(delta):
	position += Vector2(0, speed * delta)  # Move the bar down

	if position.y >= target_position.y:
		if Input.is_action_just_pressed("1"):
			# Player pressed the button at the right time
			# Implement feedback, score increase, etc.
			queue_free()  # Remove the bar from the scene
		else:
			# Player missed the button
			# Implement any penalty or game over logic
			queue_free()

	if position.y > get_viewport_rect().size.y:
		# Bar has passed the bottom of the screen
		# Implement any penalty or game over logic
		queue_free()
