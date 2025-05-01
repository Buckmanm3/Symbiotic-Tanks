extends Control

func _ready() -> void:
	$Panel/AnimatedSprite2D.play()

func _process(delta: float) -> void:
	$Panel/AnimatedSprite2D.scale = $Panel.scale
	$Panel/AnimatedSprite2D.position = $Panel.size/2

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Test Stuff/Grab Sphere.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/Options_Menu.tscn")
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
