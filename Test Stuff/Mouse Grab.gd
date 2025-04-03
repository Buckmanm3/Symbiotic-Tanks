extends MeshInstance3D

var mouseOver:bool = false
var offset:Vector2 
func _process(delta: float) -> void:
	if mouseOver:
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			offset = get_viewport().get_mouse_position()
			position = Vector3(offset.x, offset.y, position.z)
			print(position)

func _on_area_3d_mouse_entered() -> void:
	mouseOver = true;
	scale = scale + Vector3(.05, .05, .05)
	print("hover")
	pass # Replace with function body.

func _on_area_3d_mouse_exited() -> void:
	mouseOver = false;
	scale = scale - Vector3(.05, .05, .05)
	print("end hover")
	pass # Replace with function body.
