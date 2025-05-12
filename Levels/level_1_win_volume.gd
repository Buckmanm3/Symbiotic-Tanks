extends Node3D


var numNodes : int = 0

func _process(delta: float) -> void:
	if numNodes >= 4:
		get_tree().change_scene_to_file("res://Menus/NewMainMenu.tscn")

func _on_area_3d_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent().has_signal("snap"):
			if area.get_parent().snapped:
				numNodes += 1
			


func _on_area_3d_area_shape_exited(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent() != null:
		if area.get_parent().has_signal("snap"):
			if area.get_parent().snapped:
				numNodes -= 1
