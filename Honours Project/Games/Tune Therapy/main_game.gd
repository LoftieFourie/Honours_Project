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
var spawned_blocks := []
var CurSong
var NexSong
var startSong: Timer
var MotBarCount = 0
var Mot1 = null
var Mot1Done = null
var Mot2 = null
var Mot2Count = 0
var Mot2Done = null
var Mot3 = null
var Mot3Count = 0
var Mot3Done = null

func _ready():
	#$spawnTimer.start()
	var file = FileAccess.open("res://MusicList.txt",FileAccess.READ)
	
	while !file.eof_reached():
		songnames.append(file.get_line()) 
		counter = counter + 1
	file.close
	
	CurSong = $Label/CurSong
	NexSong = $Label2/NexSong
	var countCheck = spaceCount + 2
	
	
	
func _song(count):
	$MotivationalTimer1.stop()
	for block_instance in spawned_blocks:
		if block_instance != null:
			block_instance.queue_free()
	
	MotBarCount = 0
	spawned_blocks.clear()
	
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
	
	startSong = await get_tree().create_timer(1.5).timeout
	# Play the audio
	audio_player.play()
	
	# Lower the volume 5 seconds into the song
	$MotivationalTimer1.wait_time = 10
	$MotivationalTimer1.start()
	
	# Return the volume to full after 10 seconds
	
	


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
		if startSong != null:
			startSong.stop()
		if Mot1 != null:
			Mot1.stop()
			print("Stopped Mot1 timer")
		if Mot1Done != null:
			Mot1Done.stop()
		
		CurSong.text = songnames[spaceCount]
		if countCheck == counter:
			spaceCount = 0
			NexSong.text = songnames[spaceCount]
		else:
			spaceCount = spaceCount + 1
			NexSong.text = songnames[spaceCount]
			

		
	if Input.is_action_just_pressed("1"):
		var area_2d = $Area2D  # Replace with the actual name of your Area2D node
		if area_2d != null:
			var body = area_2d.get_overlapping_bodies()
			if body.size() > 0:
				body[0].queue_free()



func _on_spawn_timer_timeout():
	MotBarCount = MotBarCount + 1
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
	spawned_blocks.append(bar)
	
	spawnBlock()

func _on_area_2d_body_entered(body):
	pass
#	if Input.is_action_just_pressed("1"):
#		body.queue_free()


func _on_motivational_timer_1_timeout():
	print("motivational")
	audio_player.volume_db = -10
	
	await get_tree().create_timer(5.0).timeout
	audio_player.volume_db = 0  # Restore the volume to normal (0 dB)
	$MotivationalTimer1.stop()
