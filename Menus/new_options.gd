extends CanvasLayer


func _ready() -> void:
	$Control/VBoxContainer/MasterSlider.value = 100*db_to_linear(AudioServer.get_bus_volume_db(0))
	$Control/VBoxContainer/MusicSlider.value = 100*db_to_linear(AudioServer.get_bus_volume_db(1))




func _on_master_slider_changed() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db($Control/VBoxContainer/MasterSlider.value))


func _on_music_slider_changed() -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db($Control/VBoxContainer/MusicSlider.value))

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/NewMainMenu.tscn")

func _process(delta: float) -> void:
	print(AudioServer.get_bus_volume_db(1))

func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value/100)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value/100)
