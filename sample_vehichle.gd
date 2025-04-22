class_name SampleVehicle extends Node3D

@export var Nodes: Array[SnapPoint]
var NodesSnapped: Array[bool] = []
var speed: float = 0

func _ready() -> void:
	for node in Nodes:
		NodesSnapped.append(node.snapped)
		

func UpdateSnapped():
	var len:int = Nodes.size()
	for n in len:
		NodesSnapped[n] = Nodes[n].snapped
