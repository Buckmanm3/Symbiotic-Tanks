class_name Player extends Node3D

var holding: bool = false
var movingCamera: bool = false
var vehicleConfig: SampleVehicle
var moveSpeed: float = 0

func _ready() -> void:
	vehicleConfig = get_node("Vehicle")


func _process(delta: float) -> void:
	# moveSpeed = vehicleConfig.speed
	pass
