class_name SnapPoint extends MeshInstance3D

var snapped : bool = false
var connectedNode : BaseNode = null
var currentHealth : int = 0
enum type {wheel, body, weapon}
@export var nodeType: type

func _ready() -> void:
	SetTypeColor()
	
func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent().get_parent() != null:
			if area.get_parent().get_parent().has_method("getGrabed"):
				if connectedNode == null:
					snapped = true
					connectedNode = area.get_parent().get_parent()
					connectedNode.base.sleeping = true;
					print("Snap")

func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent().get_parent() != null:
			if area.get_parent().get_parent().has_method("getGrabed"):
				if connectedNode != null:
					snapped = false
					connectedNode.base.sleeping = false;
					connectedNode = null
					print("Unsnap")

func _process(delta: float) -> void:
	if snapped:
		if !connectedNode.holding:
			connectedNode.global_position = global_position
			
func SetTypeColor():
	var mat = StandardMaterial3D.new()
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	if nodeType == 0: # wheels are green
		print("green: " + str(nodeType))
		mat.albedo_color = Color(0, 1, 0, .25)
	elif nodeType == 1: # weapons are Red
		mat.albedo_color = Color(1, 0, 0, .25)
		print("red: " + str(nodeType))
	else: # body nodes are blue
		mat.albedo_color = Color(0, 0, 1, .25)
	$".".set_surface_override_material(0, mat)
	
