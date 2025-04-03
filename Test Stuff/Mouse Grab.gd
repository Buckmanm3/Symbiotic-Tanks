extends MeshInstance3D

var mouseOver:bool = false
var holding:bool = false
var offset:Vector3

func _process(delta: float) -> void:
	var mousePos = get_viewport().get_mouse_position()
	if mouseOver or holding:
		
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			offset = get_viewport().get_camera_3d().project_position(mousePos, get_viewport().get_camera_3d().project_ray_origin(mousePos).z)
			position = offset
			print(get_viewport().get_camera_3d().project_ray_origin(mousePos).z)
			holding = true
		else:
			holding = false
	print(getMouseWorldPos())

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
	
	
# from: https://github.com/Chevifier/ChevifierTutorials
# usefull if you don't wnat to use 
func getMouseWorldPos():
	var space = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var start = get_viewport().get_camera_3d().project_ray_origin(mousePos)
	var end = get_viewport().get_camera_3d().project_position(mousePos, 10)
	var rayParams = PhysicsRayQueryParameters3D.new()
	rayParams.from = start
	rayParams.to = end
	
	var intersect = space.intersect_ray(rayParams)
	return intersect
