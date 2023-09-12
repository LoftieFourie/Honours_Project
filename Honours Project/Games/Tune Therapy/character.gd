extends Node2D

@onready var _animation_player = $AnimationPlayer
var state
signal timer_timed_out

func _process(_delta):
	if GameData.scene == "intro":
		state = "intro"
	
	if GameData.scene == "main_game":
		state = "dancing"
		
	if $mtoivational1.time_left > 0: 
		state = "motivation1"
		
	_animation_player.play(state)


func _on_mtoivational_1_timeout():
	$mtoivational1.stop()
	print("timeout")
	state = "dancing"
	_animation_player.play(state)
	emit_signal("timer_timed_out")


func _on_ready():
	pass
