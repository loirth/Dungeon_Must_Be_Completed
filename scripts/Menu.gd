extends Control


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/lvl_1.tscn")


func _on_back_button_pressed():
	$TilesInfo.visible = false
	$Levels.visible = false


func _on_tiles_info_button_pressed():
	$TilesInfo.visible = true

func _on_lvl_button_pressed():
	$Levels.visible = true


func _on_lvl_1_pressed():
	LvlManager.change_lvl(1)

