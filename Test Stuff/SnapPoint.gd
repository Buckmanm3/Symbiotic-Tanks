class_name SnapPoint extends MeshInstance3D

var snapped : bool = false
var connectedNode : Grabbable = null

func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	
	if area.get_parent() != null:
		if area.get_parent().has_method("getGrabed"):
			if connectedNode == null:
				snapped = true
				connectedNode = area.get_parent()

func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent().has_method("getGrabed"):
			if connectedNode != null:
				snapped = false
				connectedNode = null

func _process(delta: float) -> void:
	if snapped:
		if !connectedNode.holding:
			connectedNode.global_position = global_position
