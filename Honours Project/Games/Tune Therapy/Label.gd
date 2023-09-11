extends Label

var animation_player: AnimationPlayer

func _ready():
	animation_player = $AnimationPlayer
	animation_player.play("breathing_animation")  # Replace with your animation name
