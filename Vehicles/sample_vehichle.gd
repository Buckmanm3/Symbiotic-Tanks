class_name SampleVehicle extends Vehicle

@export var Nodes: Array[SnapPoint]
var NodesSnapped: Array[bool] = []

func _ready() -> void:
	for node in Nodes:
		NodesSnapped.append(node.snapped)
		node.snap.connect(UpdateSnapped)

func UpdateSnapped():
	var size:int = Nodes.size()
	for n in size:
		NodesSnapped[n] = Nodes[n].snapped
	UpdateSpeed()

func UpdateSpeed():
	speed = 0
	turn = 0
	var size:int = Nodes.size()
	for n in size:
		if NodesSnapped[n]:
			speed += Nodes[n].getSpeed()
			turn += Nodes[n].getTurn()
