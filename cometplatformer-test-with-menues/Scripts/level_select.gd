extends Control


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level1.tscn")


func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level2.tscn")


func _on_level_3_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level3.tscn")


func _on_level_4_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level4.tscn")


func _on_level_5_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level5.tscn")


func _on_level_6_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level6.tscn")


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menues/main_menu.tscn")
