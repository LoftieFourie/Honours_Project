 extends Node


var songContainer

func _ready():
	# Assign the label node to the variable
	songContainer = $Label/songContainer

	print("running")
	loadAndDisplaySongNames()
	
func addMusic():
	$Button/FileDialog.current_dir = "/Users/Public"
	
	$Button/FileDialog.mode = FileDialog.FILE_MODE_OPEN_FILE
	$Button/FileDialog.popup()

func _process(delta):
	if Input.is_action_just_pressed("addMusic"):
		get_tree().change_scene_to_file("res://intro.tscn")


func _on_file_dialog_dir_selected(dir):
	# Handle the selected directory.
	print("Selected Directory:", dir)
	# You can process or load files from the selected directory here.


func _on_file_dialog_file_selected(path):
	var destination_folder = "res://Music/"
	
	# Get the filename from the source path
	var filename = path.get_file()

	# Construct the destination path
	var destination_path = destination_folder + filename

	# Use the File class to copy the file
	var file = FileAccess.open(path, FileAccess.READ)
	
	var newfile = FileAccess.open(destination_path, FileAccess.WRITE)
	var buffer_size = 4096
	var buffer = PackedByteArray()
	buffer.append(buffer_size)
	while !file.eof_reached():
		var read_bytes = file.get_buffer(buffer_size)
		newfile.store_buffer(read_bytes)
	newfile.close()
	file.close()
	
	var uploads_file_path = "res://Music/MusicUploads.txt"
	var uploads_file = FileAccess.file_exists(uploads_file_path)
	print(uploads_file)
	# Open the file in append mode to add the new file name
	if uploads_file == true:
		print(uploads_file)
		uploads_file = FileAccess.open(uploads_file_path, FileAccess.READ_WRITE)
	else:
		uploads_file = FileAccess.open(uploads_file_path, FileAccess.WRITE)
	
	uploads_file.seek_end()
	uploads_file.store_string(filename + "\n")
	uploads_file.close()

func loadAndDisplaySongNames():
	var uploads_file_path = "res://MusicList.txt"
	var uploads_file = FileAccess.open(uploads_file_path, FileAccess.READ)
	
	if uploads_file:
		

		var songList = uploads_file.get_as_text().strip_edges()
		uploads_file.close()
		
		if songList:
		# Split the song list into individual song names
			var songs = songList.split("\n")
			# Iterate through the songs and create labels and remove buttons
			for song_name in songs:
				
				if song_name.strip_edges(true, true) != "":
					# Create a VBoxContainer to hold each label and button pair
					var vbox = $Label/songContainer

					# Create a label for the song
					var songLabel = Label.new()
					songLabel.text = song_name
					
					#var songContainer = HBoxContainer.new()
					# Create a remove button for the song
					var removeButton = Button.new()
					removeButton.text = "Remove"
					removeButton.connect("pressed", Callable(self, "_on_remove_button_pressed").bind(song_name))

					# Add the label and button to the VBoxContainer
					songContainer.add_child(songLabel)
					songContainer.add_child(removeButton)

		else:
			var songLabel = Label.new()
			songLabel.text = "There are currently no songs in the playlist"
			songContainer.add_child(songLabel)
	else:
		print("Failed to open 'MusicList.txt'")


func _on_remove_button_pressed(song_name):
	var uploads_file_path = "res://MusicList.txt"
	var uploads_file = FileAccess.open(uploads_file_path, FileAccess.READ)
	
	if uploads_file:
		var songList = uploads_file.get_as_text().strip_edges()
		uploads_file.close()
		
		# Split the song list into individual song names
		var songs = songList.split("\n")
		
		# Remove the selected song from the list
		var updatedSongs = []
		for song in songs:
			if song.strip_edges(true, true) != "" and song.strip_edges(true,true) != song_name:
				updatedSongs.append(song)
		
		# Save the updated song list back to the file
		uploads_file = FileAccess.open(uploads_file_path, FileAccess.WRITE)
		uploads_file.store_string("\n".join(updatedSongs) + "\n")
		uploads_file.close()
		
		# Now, you can delete the file from the file system
		var music_folder = "res://Music/"
		var song_to_delete_path = music_folder + song_name
		var txtFileToDel = song_to_delete_path + ".txt"
		
		DirAccess.remove_absolute(song_to_delete_path)
		DirAccess.remove_absolute(txtFileToDel)
#		if file:
#			file = FileAccess.open(song_to_delete_path, FileAccess.WRITE)
#			file.close()
#			if file.remove(song_to_delete_path) != OK:
#				print("Failed to remove the file: " + song_to_delete_path)
		
	else:
		print("Failed to open 'MusicList.txt'")
	for child in songContainer.get_children():
		child.queue_free()
	_ready()
		
