extends CanvasLayer

signal start_game
var game_over = true

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game over")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the\nCreeps"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	game_over = true
	
		
func _process(delta):
	if Input.is_action_pressed("start_game"):
		if(game_over == true):
			_on_start_button_pressed()
			$StartButton.hide()
			game_over = false
			
	if Input.is_action_pressed("exit"):
		get_tree().quit()
		
	
func update_score(score):
	$ScoreLabel.text = str(score)


func _on_message_timer_timeout():
	$Message.hide()


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	game_over = false
