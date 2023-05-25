extends Line2D

signal hit

func _dead(area):
	print("hit")
	hit.emit()



func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("hit")



