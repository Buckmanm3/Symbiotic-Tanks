class_name SnapPoint extends MeshInstance3D







func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent().has_method("getGrabed"):
			print("SNAP")
			# maybe pass this object to Grab sphere so it can check if it should snap or not
			# clear node when node exits area
			# have bool to detect if node has already snapped
	pass # Replace with function body.


func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
