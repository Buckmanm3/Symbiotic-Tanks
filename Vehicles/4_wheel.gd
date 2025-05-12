extends VehicleBody3D

@export var points : Array[SnapPoint]
var NodesSnapped: Array[bool] = []
var speed : float = 0
var turn : float = 0


func _ready() -> void:
	for node in points:
		NodesSnapped.append(node.snapped)
		node.snap.connect(UpdateSnapped)


func _physics_process(delta: float) -> void:
	engine_force = Input.get_axis("Decelerate", "Accelerate") * speed
	steering = move_toward(steering, Input.get_axis("Turn_Right","Turn_Left"), delta * steering)


func UpdateSnapped():
	var size:int = points.size()
	for n in size:
		NodesSnapped[n] = points[n].snapped
	UpdateSpeed()


func UpdateSpeed():
	speed = 0
	turn = 0
	var size:int = points.size()
	for n in size:
		if NodesSnapped[n]:
			speed += points[n].getSpeed()
			turn += points[n].getTurn()
