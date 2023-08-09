extends CharacterBody2D

var lvl = 1

var block_scene = preload("res://scenes/block.tscn")

@onready var ui

enum State_Type {BLOCK, SLIME_V, SLIME_H, HONEY, CRATE}
var state_type := State_Type.BLOCK

@export var speed = 300

var max_blocks = 1
var max_v_slimes = 3
var max_h_slimes = 3
var max_honeys = 3
var max_crates = 3


# Gravity
var jump_force = 150
var gravity = 0
var gravity_strenght = 200
var max_gravity_on_floor = 50
var can_add_to_gravity = true


func _ready():
	if not find_parent("MenuRoom"):
		ui = find_parent("Main").find_child("UI")
	if lvl == 1:
		max_blocks = 0
		max_v_slimes = 2
		max_h_slimes = 1
		max_honeys = 3
		max_crates = 0


func change_state_type(new_state: State_Type):
	state_type = new_state
	$Sprite2D.frame = state_type

func match_max():
	if max_blocks < 0: max_blocks = 0
	if max_h_slimes < 0: max_h_slimes = 0
	if max_v_slimes < 0: max_v_slimes = 0
	if max_honeys < 0: max_honeys = 0
	if max_crates < 0: max_crates = 0
	ui.change_labels()

func init():
	var block = block_scene.instantiate()
	find_parent("Main").add_child(block)
	block.change_frame(state_type)
	var block_position = $BlockPosition.global_position
	while int(block_position.x) % 32 != 0:
		block_position.x -= 1
	while int(block_position.y) % 32 != 0:
		block_position.y -= 1
	block.position.x = int(block_position.x)
	block.position.y = int(block_position.y)

func init_block():
	if state_type == State_Type.BLOCK && max_blocks > 0:
		init()
		max_blocks -= 1
	if state_type == State_Type.SLIME_V && max_v_slimes > 0:
		init()
		max_v_slimes -= 1
	if state_type == State_Type.SLIME_H && max_h_slimes > 0:
		init()
		max_h_slimes -= 1
	if state_type == State_Type.HONEY && max_honeys > 0:
		init()
		max_honeys -= 1
	if state_type == State_Type.CRATE && max_crates > 0:
		init()
		max_crates -= 1


func apply_gravity():
	if can_add_to_gravity: gravity += 4
	
	if is_on_ceiling():
		gravity = 1
	
	if is_on_floor() && gravity >= 50:
		gravity = 50


func _physics_process(delta):
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	velocity.y = gravity * gravity_strenght * delta
	
	# Movement
	if Input.is_action_pressed("right"):
		velocity.x = speed
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.5)

	# State_changing
	if Input.is_action_just_pressed("next_type"):
		change_state_type(state_type + 1 if state_type < 4 else State_Type.BLOCK)
		
	if Input.is_action_just_pressed("previous_type"):
		change_state_type(state_type - 1 if state_type > 0 else State_Type.CRATE)
	
	
	if Input.is_action_just_pressed("set"):
		init_block()
		match_max()

	
	if Input.is_action_pressed("jump") && is_on_floor():
		gravity = -jump_force
	apply_gravity()
	
	move_and_slide()
