extends Node

@export var bar_scene: PackedScene
var spawned_node: Node2D
var path_follow: PathFollow2D
var barPath: NodePath
var spawnTime: Timer
var songnames = []
var counter = 0
var spaceCount = 0
var audio_player = null
var song = []
var timeElapsed = 0
var noteCount = 0

func _ready():
	#$spawnTimer.start()
	var file = FileAccess.open("res://MusicList.txt",FileAccess.READ)
	
	while !file.eof_reached():
		songnames.append(file.get_line()) 
		counter = counter + 1
	file.close
	
	
func _song(count):
	timeElapsed = 0
	noteCount = 0
	if audio_player != null:
		audio_player.stop()
		audio_player.queue_free()
		
	var songpath = "res://Music/" + songnames[count]

	var audio_stream = load(songpath)  
	

	audio_player = AudioStreamPlayer.new()
	audio_player.stream = audio_stream
	
	add_child(audio_player)
	
	
	
	var path = songnames[count]
	var timestamps = FileAccess.open("res://Music/" + path + ".txt",FileAccess.READ)
	song.clear()
	while !timestamps.eof_reached():
		song.append(timestamps.get_line())
		
	
	spawnBlock()
	
	await get_tree().create_timer(1.8).timeout
	# Play the audio
	audio_player.play()
	

func spawnBlock():
	var prevTime = 0
	
	var lastTime = int(song.size())
	if timeElapsed >= float(song[lastTime-2]):
		$spawnTimer.stop()
		_song(spaceCount)
		var countCheck = spaceCount + 2
		if countCheck == counter:
			spaceCount = 0
		else:
			spaceCount = spaceCount + 1
		pass
		
	spawnTime = get_node("spawnTimer")
	
	var nextBlock = float(song[0])
	if timeElapsed > 0:
		noteCount = noteCount + 1
		nextBlock = float(song[noteCount]) - timeElapsed
		
	timeElapsed = timeElapsed + nextBlock
	$spawnTimer.wait_time = nextBlock
	$spawnTimer.start()
	

func _process(delta):
	if Input.is_action_just_pressed("addMusic"):
		get_tree().change_scene_to_file("res://intro.tscn")
		
	if Input.is_action_just_pressed("space"):
		$spawnTimer.stop()
		_song(spaceCount)
		var countCheck = spaceCount + 2
		if countCheck == counter:
			spaceCount = 0
		else:
			spaceCount = spaceCount + 1
		
	if Input.is_action_just_pressed("1"):
		var area_2d = $Area2D  # Replace with the actual name of your Area2D node
		if area_2d != null:
			var body = area_2d.get_overlapping_bodies()
			if body.size() > 0:
				body[0].queue_free()



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
	
	spawnBlock()

func _on_area_2d_body_entered(body):
	print("entered")
	if Input.is_action_just_pressed("1"):
		body.queue_free()
