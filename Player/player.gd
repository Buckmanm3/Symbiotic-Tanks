class_name Player extends Node3D

var holding: bool = false
var movingCamera: bool = false
var vehicleConfig: Vehicle = null
enum VehicleType {basic}
var basic_vehicle  = preload("res://Vehicles/sample_vehichle.tscn")
var target : BaseNode = null


@export var  type:VehicleType = VehicleType.basic

func _ready() -> void:
	vehicleConfig = get_node("Vehicle")
	if type == VehicleType.basic:
		vehicleConfig = basic_vehicle.instantiate()
		add_child(vehicleConfig)


func _process(delta: float) -> void:
	if Input.is_action_pressed("Accelerate"):
		position -= (global_transform.basis * Vector3(0, 0, vehicleConfig.speed))
	if Input.is_action_pressed("Decelerate"):
		position += (global_transform.basis * Vector3(0, 0, vehicleConfig.speed))
	if Input.is_action_pressed("Turn_Left"):
		rotate_y(vehicleConfig.turn)
	if Input.is_action_pressed("Turn_Right"):
		rotate_y(-1 * vehicleConfig.turn)
