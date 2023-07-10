extends Area2D

@onready var ball = get_parent()
@onready var player = find_parent("Main").find_child("Player")

var node
var previous_body_type
var ok = true
var a = 2


func _ready():
	if player.lvl == 1: a = 2


func check(body, its_player = true):
	if its_player:
		if previous_body_type != body.state_type:
			ball.match_type(body.state_type)
		previous_body_type = body.state_type
	else:
		ball.match_type(body.state_type)

func _on_body_entered(body):
	if not body.name.begins_with("Player"):
		check(body, false)


func _on_body_exited(body):
	if body.state_type == 3 && a != 0:
		ok = false
		a -= 1
	if ok: ball.can_add_to_gravity = true
	ball.speed = 300 if ball.speed > 0 else -300
	previous_body_type = null
	ok = true
