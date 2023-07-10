extends CharacterBody2D

@onready var ui = find_parent("Main").find_child("UI")

var can_move = false

var tilemap_collision = false

@export var speed = 300
var direction = Vector2.RIGHT
var gravity = 0
var jump_force = 150
var can_add_to_gravity = true

var time_left

func _ready():
	$Timer.wait_time = 10
	time_left = $Timer.wait_time
	ui.set_time_label(time_left)


func set_tilemap_collision(boolean: bool):
	tilemap_collision = boolean


func match_type(player_type):
	match player_type:
		0: can_add_to_gravity = true
		1:
			can_add_to_gravity = true
			slime_bounce_v()
		2:
			can_add_to_gravity = true
			slime_bounce_h()
		3:
			can_add_to_gravity = false
			gravity = 0
			speed = 50 if speed > 0 else -50
		4: can_add_to_gravity = true


func slime_bounce_v():
	gravity = -150

func slime_bounce_h():
	speed = -speed
	$Sprite2D.flip_h = not $Sprite2D.flip_h


func apply_gravity():
	if can_add_to_gravity: gravity += 4
	
	if is_on_ceiling():
		gravity = 1
	
	if is_on_floor() && gravity >= 50:
		gravity = 50


func _physics_process(delta):
	if can_move:
		velocity.y = gravity * 200 * delta
		velocity.x = speed
		
	apply_gravity()
	move_and_slide()


func _on_timer_timeout():
	can_move = true
	time_left -= 1
	ui.set_time_label(time_left)
	$LabelTimer.stop()


func _on_label_timer_timeout():
	time_left -= 1
	ui.set_time_label(time_left)
