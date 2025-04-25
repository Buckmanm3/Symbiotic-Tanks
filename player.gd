class_name Player extends Node3D

var holding: bool = false
var movingCamera: bool = false
var vehicleConfig: Vehicle = null
var moveSpeed: float = 1
enum VehicleType {basic}
var basic_vehicle  = preload("res://Vehicles/sample_vehichle.tscn")
@export var  type:VehicleType = VehicleType.basic
func _ready() -> void:
	vehicleConfig = get_node("Vehicle")
	if type == VehicleType.basic:
		vehicleConfig = basic_vehicle.instantiate()
		add_child(vehicleConfig)


func _process(delta: float) -> void:
	if Input.is_action_pressed("Accelerate"):
		position += Vector3(0, 0, -vehicleConfig.speed)
	pass
