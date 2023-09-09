extends Node


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

