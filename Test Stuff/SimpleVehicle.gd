extends VehicleBody3D


var EnginePower : float = 100
var TurnSpeed : float = 20.0
@onready var Popwheel : VehicleWheel3D = $VehicleWheel3D
@onready var PopWheelCollide : StaticBody3D = $VehicleWheel3D/Eye/StaticBody3D
var toggle : bool = true


func _process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("Turn_Right","Turn_Left"), delta * 10)
	engine_force = Input.get_axis("Decelerate","Accelerate") * EnginePower
	print(Popwheel.position)
	if (Input.is_action_just_released("Brake")):
		if toggle:
			Popwheel.reparent(get_tree().root.get_child(0))
			toggle = false;
		else:
			Popwheel.reparent(self)
			Popwheel.position = Vector3(-.7, .114, -.72)
			toggle = true;
			
