extends Node

var player1 = false
var player2 = false
var player3 = false
var player4 = false
var player5 = false
var player6 = false

func _ready():
	$BoxContainer/Label1.add_theme_color_override("font_color","RED")
	$BoxContainer/Label2.add_theme_color_override("font_color","RED")
	$BoxContainer/Label3.add_theme_color_override("font_color","RED")
	$BoxContainer/Label4.add_theme_color_override("font_color","RED")
	$BoxContainer/Label5.add_theme_color_override("font_color","RED")
	$BoxContainer/Label6.add_theme_color_override("font_color","RED")
	

func _process(delta):
	
	if Input.is_action_just_pressed("1"):
		player1 = !player1
		if player1 == true:
			$BoxContainer/Label1.add_theme_color_override("font_color","GREEN")
		else:
			$BoxContainer/Label1.add_theme_color_override("font_color","RED")
	
	if Input.is_action_just_pressed("2"):
		player2 = !player2
		if player2 == true:
			$BoxContainer/Label2.add_theme_color_override("font_color","GREEN")
		else:
			$BoxContainer/Label2.add_theme_color_override("font_color","RED")
		
	if Input.is_action_just_pressed("3"):
		player3 = !player3
		if player3 == true:
			$BoxContainer/Label3.add_theme_color_override("font_color","GREEN")
		else:
			$BoxContainer/Label3.add_theme_color_override("font_color","RED")
	
	if Input.is_action_just_pressed("4"):
		player4 = !player4
		if player4 == true:
			$BoxContainer/Label4.add_theme_color_override("font_color","GREEN")
		else:
			$BoxContainer/Label4.add_theme_color_override("font_color","RED")
	
	if Input.is_action_just_pressed("5"):
		player5 = !player5
		if player5 == true:
			$BoxContainer/Label5.add_theme_color_override("font_color","GREEN")
		else:
			$BoxContainer/Label5.add_theme_color_override("font_color","RED")
	
	if Input.is_action_just_pressed("6"):
		player6 = !player6
		if player6 == true:
			$BoxContainer/Label6.add_theme_color_override("font_color","GREEN")
		else:
			$BoxContainer/Label6.add_theme_color_override("font_color","RED")
			
	if Input.is_action_just_pressed("addMusic"):
		get_tree().change_scene_to_file("res://upload_music.tscn")
	
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://main_game.tscn")
