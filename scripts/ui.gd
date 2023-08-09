extends Control

@onready var player = find_parent("Main").find_child("Player")


func _ready():
	change_labels()


func set_time_label(time):
	$TimeLabel.text = "Time left: " + str(time)

func change_labels():
	$LVLLabel.text = "LVL: " + str(player.lvl)
	$Block_Count/Label.text = str(player.max_blocks)
	$Slime_H_Count/Label.text = str(player.max_h_slimes)
	$Slime_V_Count/Label.text = str(player.max_v_slimes)
	$Honey_Count/Label.text = str(player.max_honeys)
	$Crate_Count/Label.text = str(player.max_crates)
