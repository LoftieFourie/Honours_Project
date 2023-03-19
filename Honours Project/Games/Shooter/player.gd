extends Area2D

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	look_at(get_global_mouse_position())
