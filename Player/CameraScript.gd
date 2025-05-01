class_name Camera3rdPerson extends SpringArm3D

@export var mouse_sensitivity: float = 0.005
@onready var orgin : Player = $".."
var rightClick: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && rightClick: # rotate if player is holding right click
		rotation.y -= event.get_relative().x * mouse_sensitivity
		rotation.y = wrapf(rotation.y, 0, TAU)
		
		rotation.x -= event.get_relative().y * mouse_sensitivity
		rotation.x = clamp(rotation.x, -PI/2, PI/4)
	if event.is_action_pressed("Toggle Camera Control"):
		rightClick = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		orgin.movingCamera = true
	elif event.is_action_released("Toggle Camera Control"):
		rightClick = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		orgin.movingCamera = false

func _process(delta: float) -> void:
	if !orgin.holding: # zoom camera in and out if not holding object
		if Input.is_action_just_released("Zoom_Out"):
				scale.z += .1
				scale.z = clamp(scale.z, .5, 1.5)
		if Input.is_action_just_released("Zoom_In"):
				scale.z -= .1
				scale.z = clamp(scale.z, .5, 1.5)
