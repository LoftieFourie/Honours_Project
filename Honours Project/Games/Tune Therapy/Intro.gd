extends Node

var player1 = false
var player2 = false
var player3 = false
var player4 = false

func _ready():
	GameData.scene = "intro"
	$Label1.add_theme_font_size_override("font_size", 30)
	$Label2.add_theme_font_size_override("font_size", 30)
	$Label3.add_theme_font_size_override("font_size", 30)
	$Label4.add_theme_font_size_override("font_size", 30)
	if GameData.players.has(1):
		player1 = true
		$Label1.add_theme_color_override("font_color","GREEN")
	else:
		$Label1.add_theme_color_override("font_color","RED")
		
	if GameData.players.has(2):
		player2 = true
		$Label2.add_theme_color_override("font_color","GREEN")
	else:
		$Label2.add_theme_color_override("font_color","RED")
		
	if GameData.players.has(3):
		player3 = true
		$Label3.add_theme_color_override("font_color","GREEN")
	else:
		$Label3.add_theme_color_override("font_color","RED")
		
	if GameData.players.has(4):
		player4 = true
		$Label4.add_theme_color_override("font_color","GREEN")
	else:
		$Label4.add_theme_color_override("font_color","RED")
	
	GameData.players.clear()


func _process(delta):
	GameData.connection.poll()
	
	var state = GameData.connection.get_status()
	
	if GameData.connection and state == GameData.connection.STATUS_CONNECTED:
		if GameData.connection.get_available_bytes() > 0:
			var s = GameData.connection.get_utf8_string(GameData.connection.get_available_bytes())
			print(str(s))
			if str(s) == "1":
				Input.action_press("1")
			elif str(s) == " ":
				Input.action_press("space")

	if Input.is_action_just_pressed("1"):
		player1 = !player1
		if player1 == true:
			$Label1.add_theme_color_override("font_color","GREEN")
		else:
			$Label1.add_theme_color_override("font_color","RED")
	
	if Input.is_action_just_pressed("2"):
		player2 = !player2
		if player2 == true:
			$Label2.add_theme_color_override("font_color","GREEN")
		else:
			$Label2.add_theme_color_override("font_color","RED")
		
	if Input.is_action_just_pressed("3"):
		player3 = !player3
		if player3 == true:
			$Label3.add_theme_color_override("font_color","GREEN")
		else:
			$Label3.add_theme_color_override("font_color","RED")
	
	if Input.is_action_just_pressed("4"):
		player4 = !player4
		if player4 == true:
			$Label4.add_theme_color_override("font_color","GREEN")
		else:
			$Label4.add_theme_color_override("font_color","RED")
	
			
	if Input.is_action_just_pressed("addMusic"):
		get_tree().change_scene_to_file("res://upload_music.tscn")
	
	if Input.is_action_just_pressed("space"):
		if player1:
			GameData.players.append(1)
			
		if player2:
			GameData.players.append(2)
		
		if player3:
			GameData.players.append(3)
			
		if player4:
			GameData.players.append(4)
		
		GameData.players.append(5)
		get_tree().change_scene_to_file("res://main_game.tscn")
