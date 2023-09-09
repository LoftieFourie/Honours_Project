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
#	if file.copy(path, destination_path) == OK:
#		print("File copied successfully.")
#	else:
#		print("Failed to copy the file.")
	file.close()

