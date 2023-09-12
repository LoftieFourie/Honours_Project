extends HBoxContainer

var animation_player: AnimationPlayer

func _process(delta):
	if Input.is_action_just_pressed("1"):
		animation_player = $AnimationPlayer
		animation_player.play("selected")
	
	if Input.is_action_just_pressed("2"):
		animation_player = $AnimationPlayer
		animation_player.play("selected")
		
	if Input.is_action_just_pressed("3"):
		animation_player = $AnimationPlayer
		animation_player.play("selected")
		
	if Input.is_action_just_pressed("4"):
		animation_player = $AnimationPlayer
		animation_player.play("selected")
