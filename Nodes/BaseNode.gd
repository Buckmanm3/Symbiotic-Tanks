extends RigidBody3D
class_name BaseNode

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var jumpTime: float = 1
var jumpCounter: float = 0
@export var friction: float = .1

var mouseOver:bool = false
var holding:bool = false
var offset:Vector3 
var player : Player  
var dist : float 
var target: bool = false
var snapped: bool = false

@onready var base : RigidBody3D = $"."
@onready var highlight : MeshInstance3D = $Highlight

@export var moveBonus: float = 0.1
@export var health: float = 0.1
@export var turnBonus: float = 0.1

func _ready() -> void:
	player = get_tree().root.get_child(0).get_node("Player")
	dist = global_position.distance_to(get_viewport().get_camera_3d().global_position)
	jumpTime = rng.randf_range(0.0, 5.0)
	
func _process(delta: float) -> void:
	var mousePos = get_viewport().get_mouse_position()
	if (mouseOver or holding) && !player.movingCamera:
		if !((player.holding || holding) && !(player.holding and holding)): # not xor :/
			if Input.is_action_just_released("Zoom_Out"):
				dist -= .1
			if Input.is_action_just_released("Zoom_In"):
				dist += .1
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				offset = get_viewport().get_camera_3d().project_position(mousePos, dist)
				position = offset
				holding = true
				player.holding = true
			else:
				holding = false
				player.holding = false
	if (!snapped && !holding):
		if (jumpCounter >= jumpTime):
			var impulse = Vector3(rng.randf_range(-0.3,0.3), rng.randf_range(0.0, 1), rng.randf_range(-0.3,0.3))
			base.apply_impulse(impulse, position)
			jumpCounter = 0
			jumpTime = rng.randf_range(3.0, 5.0)
			print("JUMP!")
		else:
			jumpCounter += delta
			applyFriction()	
		

func getGrabed():
	return holding

func _on_area_3d_mouse_entered() -> void:
		if !((player.holding || holding) && !(player.holding and holding)):
			mouseOver = true;
			#scale = scale + Vector3(.05, .05, .05)

func _on_area_3d_mouse_exited() -> void:
	if !((player.holding || holding) && !(player.holding and holding)):
		mouseOver = false;
		#scale = scale - Vector3(.05, .05, .05)
		if !holding:
			dist = global_position.distance_to(get_viewport().get_camera_3d().global_position)

func applyFriction():
	var linearVel = Vector3(lerp(base.linear_velocity.x, 0.0, friction), base.linear_velocity.y-.1, lerp(base.linear_velocity.z, 0.0, friction))
	base.linear_velocity = linearVel
	base.angular_velocity = lerp(base.angular_velocity, Vector3.ZERO, friction)
