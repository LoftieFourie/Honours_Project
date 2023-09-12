extends Node

var player1 = false
var player2 = false
var player3 = false
var player4 = false

func _ready():
	$HBoxContainer/Label1.add_theme_font_size_override("font_size", 30)
	$HBoxContainer/Label2.add_theme_font_size_override("font_size", 30)
	$HBoxContainer/Label3.add_theme_font_size_override("font_size", 30)
	$HBoxContainer/Label4.add_theme_font_size_override("font_size", 30)
	if GameData.players.has(1):
		player1 = true
		$HBoxContainer/Label1.add_theme_color_override("font_color","GREEN")
	else:
		$HBoxContainer/Label1.add_theme_color_override("font_color","RED")
		
	if GameData.players.has(2):
		player2 = true
		$HBoxContainer/Label2.add_theme_color_override("font_color","GREEN")
	else:
		$HBoxContainer/Label2.add_theme_color_override("font_color","RED")
		
	if GameData.players.has(3):
		player3 = true
		$HBoxContainer/Label3.add_theme_color_override("font_color","GREEN")
	else:
		$HBoxContainer/Label3.add_theme_color_override("font_color","RED")
		
	if GameData.players.has(4):
		player4 = true
		$HBoxContainer/Label4.add_theme_color_override("font_color","GREEN")
	else:
		$HBoxContainer/Label4.add_theme_color_override("font_color","RED")
	
	GameData.players.clear()
	

func _process(delta):
	
	if Input.is_action_just_pressed("1"):
		player1 = !player1
		if player1 == true:
			$HBoxContainer/Label1.add_theme_color_override("font_color","GREEN")
		else:
			$HBoxContainer/Label1.add_theme_color_override("font_color","RED")
	
	if Input.is_action_just_pressed("2"):
		player2 = !player2
		if player2 == true:
			$HBoxContainer/Label2.add_theme_color_override("font_color","GREEN")
		else:
			$HBoxContainer/Label2.add_theme_color_override("font_color","RED")
		
	if Input.is_action_just_pressed("3"):
		player3 = !player3
		if player3 == true:
			$HBoxContainer/Label3.add_theme_color_override("font_color","GREEN")
		else:
			$HBoxContainer/Label3.add_theme_color_override("font_color","RED")
	
	if Input.is_action_just_pressed("4"):
		player4 = !player4
		if player4 == true:
			$HBoxContainer/Label4.add_theme_color_override("font_color","GREEN")
		else:
			$HBoxContainer/Label4.add_theme_color_override("font_color","RED")
	
			
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
		
		get_tree().change_scene_to_file("res://main_game.tscn")
