extends CanvasLayer
# @onready var videoPlayer : VideoStreamPlayer = $Control/AspectRatioContainer/VideoStreamPlayer



func _ready() -> void:
	# videoPlayer.expand = true;
	pass



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Test Stuff/Grab Sphere.tscn")
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/NewOptions.tscn")
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()
