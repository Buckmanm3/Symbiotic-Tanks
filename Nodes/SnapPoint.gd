class_name SnapPoint extends MeshInstance3D

var snapped : bool = false
var connectedNode : BaseNode = null
var currentHealth : int = 0
enum type {wheel, body, weapon}
@export var nodeType: type
signal	snap

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
					connectedNode.snapped = true;
					snap.emit()

func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent().get_parent() != null:
			if area.get_parent().get_parent().has_method("getGrabed"):
				if connectedNode != null:
					snapped = false
					connectedNode.base.sleeping = false;
					connectedNode.snapped = false;
					connectedNode = null
					snap.emit()

func _process(delta: float) -> void:
	if snapped:
		if !connectedNode.holding:
			connectedNode.global_position = global_position
			
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
