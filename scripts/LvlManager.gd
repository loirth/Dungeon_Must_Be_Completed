extends Node

var LVL = {1: "res://scenes/lvl_1.tscn"}

var lvl = 1

func change_lvl(level = null):
	if level:
		get_tree().change_scene_to_file(LVL[level])
