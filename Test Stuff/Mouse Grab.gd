class_name Grabbable extends MeshInstance3D

var mouseOver:bool = false
var holding:bool = false
var offset:Vector3
@onready var area : Area3D = $Area3D
@onready var dist:float = get_viewport().get_camera_3d().position.distance_to(area.position)


func _process(delta: float) -> void:
	var mousePos = get_viewport().get_mouse_position()
	if mouseOver or holding:
		if Input.is_action_just_released("Zoom_Out"):
			dist -= .1
		if Input.is_action_just_released("Zoom_In"):
			dist += .1
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			offset = get_viewport().get_camera_3d().project_position(mousePos, dist)
			position = offset
			holding = true
		else:
			holding = false
	else:
		dist = get_viewport().get_camera_3d().position.distance_to(area.position)
	

func _on_area_3d_mouse_entered() -> void:
	mouseOver = true;
	scale = scale + Vector3(.05, .05, .05)

func _on_area_3d_mouse_exited() -> void:
	mouseOver = false;
	scale = scale - Vector3(.05, .05, .05)
	
func getGrabed():
	return holding
