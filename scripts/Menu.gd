extends Control


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_back_button_pressed():
	$Control.visible = false


func _on_htp_button_pressed():
	$Control.visible = true
