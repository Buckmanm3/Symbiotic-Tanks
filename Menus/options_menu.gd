extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/HSlider.set_value_no_signal(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))) 

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/Main Menu.tscn")
