class_name SampleVehicle extends Vehicle

@export var Nodes: Array[SnapPoint]
var NodesSnapped: Array[bool] = []

func _ready() -> void:
	speed = 0
	for node in Nodes:
		NodesSnapped.append(node.snapped)
	Nodes[1].snap.connect(UpdateSnapped)

func UpdateSnapped():
	var size:int = Nodes.size()
	for n in size:
		NodesSnapped[n] = Nodes[n].snapped
	UpdateSpeed()

func UpdateSpeed():
	speed = 0
	var size:int = Nodes.size()
	for n in size:
		if NodesSnapped[n]:
			speed += Nodes[n].getSpeed()
			print(Nodes[n].getSpeed())
	print("Speed: " + str(speed))
