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
var Mot2Done = null
var Mot3 = null
var Mot3Done = null
var Player1Count = 0
var Player2Count = 0
var Player3Count = 0
var Player4Count = 0
var DoubletapCount = 0
var animation_player: AnimationPlayer
var songTime = 0

func _ready():
	GameData.scene = "main_game"
	$Character.hide()
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
	Player1Count = 0
	Player2Count = 0
	Player3Count = 0
	Player4Count = 0
	
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
	songTime = audio_stream.get_length()

	var path = songnames[count]
	var timestamps = FileAccess.open("res://Music/" + path + ".txt",FileAccess.READ)
	song.clear()
	while !timestamps.eof_reached():
		song.append(timestamps.get_line())
		
	
	spawnBlock()
	
	startSong = await get_tree().create_timer(2.1).timeout
	# Play the audio
	audio_player.play()
	
	
	$MotivationalTimer1.wait_time = songTime * 0.10
	$MotivationalTimer2.wait_time = songTime * 0.75
	print(songTime * 0.25)
	$MotivationalTimer1.start()
	$MotivationalTimer2.start()
	
	# Return the volume to full after 10 seconds
	
	


func spawnBlock():
	var prevTime = 0
	
	var lastTime = int(song.size())
	if timeElapsed >= float(song[lastTime-2]):
		$spawnTimer.stop()
		await get_tree().create_timer(3).timeout
		_song(spaceCount)
		var countCheck = spaceCount + 2
		CurSong.text = songnames[spaceCount]
		if countCheck == counter:
			spaceCount = 0
			NexSong.text = songnames[spaceCount]
		else:
			spaceCount = spaceCount + 1
			NexSong.text = songnames[spaceCount]
		pass
		
	spawnTime = get_node("spawnTimer")
	
	var nextBlock = float(song[0])
	if timeElapsed > 0:
		noteCount = noteCount + 1
		if noteCount < song.size():
			nextBlock = float(song[noteCount]) - timeElapsed
		
	timeElapsed = timeElapsed + nextBlock
	$spawnTimer.wait_time = nextBlock
	$spawnTimer.start()
	

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
	if Input.is_action_just_pressed("addMusic"):
		get_tree().change_scene_to_file("res://intro.tscn")
		
	if Input.is_action_just_pressed("space"):
		$HUD.hide()
		if $Character.hidden:
			$Character.show()
		$spawnTimer.stop()
		DoubletapCount = DoubletapCount + 1
		if DoubletapCount == 2:
			get_tree().change_scene_to_file("res://intro.tscn")
		await get_tree().create_timer(0.5).timeout
		DoubletapCount = 0
		
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
			

	if GameData.players.has(1):
		if Input.is_action_just_pressed("1"):
			var area_2d = $Area2D  # Replace with the actual name of your Area2D node
			if area_2d != null:
				var body = area_2d.get_overlapping_bodies()
				if body.size() > 0:
					body[0].collision_layer = 0
					body[0].collision_mask = 0
					body[0].linear_velocity = Vector2(0.0, 0.0)
					body[0].dequeue_item()
					Player1Count = Player1Count + 1
					
	if GameData.players.has(2):
		if Input.is_action_just_pressed("2"):
			var area_2d = $Area2D  # Replace with the actual name of your Area2D node
			if area_2d != null:
				var body = area_2d.get_overlapping_bodies()
				if body.size() > 0:
					body[0].collision_layer = 0
					body[0].collision_mask = 0
					body[0].linear_velocity = Vector2(0.0, 0.0)
					body[0].dequeue_item()
					Player2Count = Player2Count + 1
					
	if GameData.players.has(3):
		if Input.is_action_just_pressed("3"):
			var area_2d = $Area2D  # Replace with the actual name of your Area2D node
			if area_2d != null:
				var body = area_2d.get_overlapping_bodies()
				if body.size() > 0:
					body[0].collision_layer = 0
					body[0].collision_mask = 0
					body[0].linear_velocity = Vector2(0.0, 0.0)
					body[0].dequeue_item()
					Player3Count = Player3Count + 1
					
	if GameData.players.has(4):
		if Input.is_action_just_pressed("4"):
			var area_2d = $Area2D  # Replace with the actual name of your Area2D node
			if area_2d != null:
				var body = area_2d.get_overlapping_bodies()
				if body.size() > 0:
					body[0].collision_layer = 0
					body[0].collision_mask = 0
					body[0].linear_velocity = Vector2(0.0, 0.0)
					body[0].dequeue_item()
					Player4Count = Player4Count + 1



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
	spawned_blocks.append(bar)
	
	spawnBlock()

func _on_area_2d_body_entered(body):
	MotBarCount = MotBarCount + 1



func _on_motivational_timer_1_timeout():
	var songpath = chooseMoti() + ".mp3"
	print(songpath)

	var audio_stream = load(songpath)  


	var moticlip = AudioStreamPlayer.new()
	moticlip.stream = audio_stream
	var duration_seconds = audio_stream.get_length()
	print(duration_seconds)
	add_child(moticlip)
	moticlip.volume_db = 5
	moticlip.play()
	$Character/mtoivational1.wait_time = duration_seconds + 0.2
	$Character/mtoivational1.start()
	print(MotBarCount)
	print(Player1Count)
	print(Player2Count)
	audio_player.volume_db = -10
	$MotivationalTimer1.stop()



func _on_character_timer_timed_out():
	print("done")
	audio_player.volume_db = 0
	


func _on_motivational_timer_2_timeout():
	var songpath = chooseMoti() + ".mp3"

	var audio_stream = load(songpath)  


	var moticlip = AudioStreamPlayer.new()
	moticlip.stream = audio_stream
	var duration_seconds = audio_stream.get_length()
	print(duration_seconds)
	add_child(moticlip)
	moticlip.volume_db = 5
	moticlip.play()
	$Character/mtoivational1.wait_time = duration_seconds + 0.2
	$Character/mtoivational1.start()
	print(MotBarCount)
	print(Player1Count)
	print(Player2Count)
	audio_player.volume_db = -10
	$MotivationalTimer2.stop()

func chooseMoti():
	var path1
	var path2
	var finalDest
	var entirePath
	var amount = GameData.players
	var randomIndex = randi() % amount.size()  # Get a random index within the array size
	var randomValue = amount[randomIndex]
	if randomValue == 1:
		path2 = "1"
		if Player1Count >= MotBarCount*0.75:
			finalDest = randi() % 3 + 1
			path1 = "1"
		elif Player1Count >= MotBarCount*0.50:
			finalDest = randi() % 2 + 1
			path1 = "2"
		else:
			finalDest = randi() % 2 + 1
			path1 = "3"
		
		entirePath = "motivation/"+str(path1)+"/"+str(path2)+"/"+str(finalDest)
		
		return entirePath
	elif randomValue == 2:
		path2 = "2"
		if Player2Count >= MotBarCount*0.75:
			finalDest = randi() % 3 + 1
			path1 = "1"
		elif Player2Count >=  MotBarCount*0.50:
			finalDest = randi() % 2 + 1
			path1 = "2"
		else:
			finalDest = randi() % 2 + 1
			path1 = "3"
		
		entirePath = "motivation/"+str(path1)+"/"+str(path2)+"/"+str(finalDest)
		
		return entirePath
	elif randomValue == 3:
		path2 = "3"
		if Player3Count >= MotBarCount*0.75:
			finalDest = randi() % 3 + 1
			path1 = "1"
		elif Player3Count >= MotBarCount*0.50:
			finalDest = randi() % 2 + 1
			path1 = "2"
		else:
			finalDest = randi() % 2 + 1
			path1 = "3"
		
		entirePath = "motivation/"+str(path1)+"/"+str(path2)+"/"+str(finalDest)
		
		return entirePath
	elif randomValue == 4:
		path2 = "4"
		if Player3Count >= MotBarCount*0.75:
			finalDest = randi() % 3 + 1
			path1 = "1"
		elif Player3Count >= 50:
			finalDest = randi() % 2 + 1
			path1 = "2"
		else:
			finalDest = randi() % 2 + 1
			path1 = "3"
		
		entirePath = "motivation/"+str(path1)+"/"+str(path2)+"/"+str(finalDest)
		
		return entirePath
	else:
		path1 = "all"
		finalDest = randi() % 3 + 1
		
		entirePath = "motivation/"+path1+"/"+str(finalDest)
		return entirePath
