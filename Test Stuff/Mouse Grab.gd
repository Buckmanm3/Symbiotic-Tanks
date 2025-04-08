extends MeshInstance3D

var mouseOver:bool = false
var holding:bool = false
var offset:Vector3
@onready var dist:float = get_viewport().get_camera_3d().position.distance_to(position)

func _process(delta: float) -> void:
	var mousePos = get_viewport().get_mouse_position()
	if mouseOver or holding:
		if Input.is_action_just_released("Zoom_Out"):
			dist -= .1
			print(dist)
		if Input.is_action_just_released("Zoom_In"):
			dist += .1
			print(dist)
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			offset = get_viewport().get_camera_3d().project_position(mousePos, dist) #* (get_viewport().get_camera_3d().position.distance_to(position) * get_viewport().get_camera_3d().position.direction_to(position))
			position = offset
			print(offset)
			print(get_viewport().get_camera_3d().project_ray_origin(mousePos).z)
			holding = true
		else:
			holding = false
	else:
		dist = get_viewport().get_camera_3d().position.distance_to(position)

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
