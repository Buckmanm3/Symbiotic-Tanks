class_name Grabbable extends MeshInstance3D

"""
Results:
	-proof of concept is great, it showed this project is a realistic goal/idea
	-having the code within the object is nice for simplicty sake but can be an issue since its isolated
		-Bug: player can grab multiple spheres at once when already holding
	-area 3d signals need to be local so there needs to be some code within the object
	-need ref to player object which can tell if an object is currently being held
	-Snap Grid stuff is very possible it just may need some good structure planning
		-if a both snap-node and node need to store if they are attached
			-avoid snapping multiple nodes to one grid spot
			-node needs position to update each frame
			-node needs to know when it is released within deadzone so it can snap
"""


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
