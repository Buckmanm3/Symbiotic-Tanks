class_name NewBase extends VehicleWheel3D

# vehicle vars
@export var moveBonus: float = 0.1
@export var health: float = 0.1
@export var turnBonus: float = 0.1

# grab vars
var mouseOver:bool = false
var holding:bool = false
var dist : float 
var offset:Vector3

# jump vars
@onready var body : RigidBody3D =  $Collider
@export_range(0,1) var friction : float = .1
var player : Player
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var jumpTime: float = 1
var jumpCounter: float = 0


func _ready() -> void:
	player = get_tree().root.get_child(0).get_node("Player") # get player
	jumpTime = rng.randf_range(0.0, 5.0) # get random jump time


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
	jump(delta)


func _on_mouse_collider_mouse_entered() -> void:
	if !((player.holding || holding) && !(player.holding and holding)):
			mouseOver = true;


func _on_mouse_collider_mouse_exited() -> void:
	if !((player.holding || holding) && !(player.holding and holding)):
		mouseOver = false;


func jump(delta:float):
	if (!snapped && !holding):
		if (jumpCounter >= jumpTime):
			var impulse = Vector3(rng.randf_range(-0.3,0.3), rng.randf_range(0.0, 1), rng.randf_range(-0.3,0.3))
			body.apply_impulse(impulse, position)
			jumpCounter = 0
			jumpTime = rng.randf_range(3.0, 5.0)
		else:
			jumpCounter += delta
			applyFriction()	


func applyFriction():
	var linearVel = Vector3(lerp(body.linear_velocity.x, 0.0, friction), body.linear_velocity.y-.1, lerp(body.linear_velocity.z, 0.0, friction))
	body.linear_velocity = linearVel
	body.angular_velocity = lerp(body.angular_velocity, Vector3.ZERO, friction)
	
