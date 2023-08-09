extends Area2D


func _on_body_entered(body):
	if body.name.begins_with("Ball"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
