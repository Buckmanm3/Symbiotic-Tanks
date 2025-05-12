extends VehicleBody3D


var EnginePower : float = 100
var TurnSpeed : float = 20.0

func _process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis("Turn_Right","Turn_Left"), delta * 10)
	engine_force = Input.get_axis("Decelerate","Accelerate") * EnginePower
	print(Input.get_axis("Accelerate","Decelerate"))
