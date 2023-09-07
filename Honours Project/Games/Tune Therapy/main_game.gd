extends Node

@export var bar_scene: PackedScene
var spawned_node: Node2D
var path_follow: PathFollow2D
var barPath: NodePath

func _ready():
	$spawnTimer.start()
	var file = FileAccess.open("res://Music/MusicUploads.txt",FileAccess.READ)
	var counter = 0
	var popcounter = 0
	var songnames = []
	while !file.eof_reached():
		songnames.append(file.get_line()) 
		counter = counter + 1
	file.close
	
	file = FileAccess.open("res://Music/MusicUploads.txt",FileAccess.READ)
	
	var songpath = "res://Music/" + songnames[0]
	
	var audio_stream = load(songpath)  
	

	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = audio_stream
	
	add_child(audio_player)
	
	# Play the audio
	audio_player.play()
	
	print(counter)
	while popcounter <= counter - 2:
		print(file.get_line())
		#var timestamps = FileAccess.open("res://Music/" + file.get_line() + ".txt",FileAccess.READ)
		var timestamps = FileAccess.open("res://Music/Waiting.mp3.txt",FileAccess.READ)
		print()
		var song = []
		while !timestamps.eof_reached():
			song.append(timestamps.get_line())
		print(song[0])
		popcounter = popcounter + 1
		
	
	
	
func _process(delta):
	if Input.is_action_just_pressed("addMusic"):
		get_tree().change_scene_to_file("res://intro.tscn")
		



func _on_spawn_timer_timeout():
	var bar = bar_scene.instantiate()

	# Choose a random location on Path2D.
	var bar_spawn_location = get_node("barPath/barPathFollow")
	bar_spawn_location.progress_ratio = 0
	# Set the mob's direction perpendicular to the path direction.
	var direction = bar_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	bar.position = bar_spawn_location.position

	# Define the fall speed (pixels per second).
	var fall_speed = 300

	# Calculate the velocity based on the fall speed and frame time.
	var velocity = Vector2(0.0, fall_speed)

	# Set the mob's velocity.
	bar.linear_velocity = velocity

	# Spawn the mob by adding it to the Main scene.
	add_child(bar)
