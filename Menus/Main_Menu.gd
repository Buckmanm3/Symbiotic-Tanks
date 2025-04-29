extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Test Stuff/Grab Sphere.tscn")
	


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/Options_Menu.tscn")
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
