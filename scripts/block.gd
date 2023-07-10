extends StaticBody2D

@onready var sprite = $Sprite2D

enum State_Type {BLOCK, SLIME_V, SLIME_H, HONEY, CRATE}
var state_type := State_Type.BLOCK

var gravity = 0
var can_add_gravity = true

var velocity = Vector2.ZERO

func _ready():
	change_frame($Sprite2D.frame)

func change_frame(type):
	state_type = type
	$Sprite2D.frame = type


func apply_gravity():
	if gravity < 400: gravity += 4

func _physics_process(delta):
	if state_type == State_Type.HONEY: can_add_gravity = false
	velocity.y = gravity * delta
	
	if can_add_gravity: apply_gravity()
	
	move_and_collide(Vector2(0, gravity))
