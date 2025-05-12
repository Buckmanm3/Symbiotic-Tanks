class_name SnapPoint extends MeshInstance3D

var snapped : bool = false
var connectedNode : NewBase = null
var currentHealth : int = 0
enum type {wheel, body, weapon}
var ParrentVehicle : VehicleBody3D
@export var nodeType: type
signal	snap

func _ready() -> void:
	SetTypeColor()
	ParrentVehicle = get_parent() # Snap Point Must be a child of a vehicle!!!!!
	
func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent() != null:
			if area.get_parent().get_parent().has_method("jump"): # TODO this may need to change based on new nodes
				if connectedNode == null: # if we don't already have a node...
					snapped = true # init snap:
					connectedNode = area.get_parent() # set node var to parent of area
					connectedNode.reparent(ParrentVehicle) # reparent node to act as wheel
					connectedNode.global_position = global_position # snap to pos
					connectedNode.snapped = true; # tell node it has snapped
					snap.emit() # tell player we have snapped
					print("Snap")

func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent() != null:
			if area.get_parent().has_method("jump"): # TODO this may need to change based on new nodes
				if connectedNode != null: # check if we have snapped
					snapped = false # init unsnap
					connectedNode.reparent(get_tree().root.get_child(0)) # reparent node to world scene
					connectedNode.snapped = false; # tell node they have unsnapped
					connectedNode = null # clear ref to node
					snap.emit() # tell player we have unsnapped
					print("Unsnap")

func _process(delta: float) -> void:
	pass
	#if snapped:
	#	if !connectedNode.holding:
	#		connectedNode.global_position = global_position
			
func SetTypeColor():
	var mat = StandardMaterial3D.new()
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	if nodeType == 0: # wheels are green
		mat.albedo_color = Color(0, 1, 0, .25)
	elif nodeType == 1: # weapons are Red
		mat.albedo_color = Color(1, 0, 0, .25)
	else: # body nodes are blue
		mat.albedo_color = Color(0, 0, 1, .25)
	$".".set_surface_override_material(0, mat)
	
func getSpeed():
	if snapped && connectedNode != null:
		return connectedNode.moveBonus
		
func getTurn():
	if snapped && connectedNode != null:
		return connectedNode.turnBonus
