extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 1080
var gravity = 1200
var jump_force = -720
var count_jumps = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if Input.is_action_pressed("move_right") && String(transform.x) == '(1, 0)':
		transform.x = Vector2(-1, 0)
	if Input.is_action_pressed("move_left") && String(transform.x) == '(-1, 0)':
		transform.x = Vector2(1, 0)
	if Input.is_action_just_pressed("jump") &&  count_jumps < 2:
		velocity.y = jump_force
		count_jumps += 1
	if velocity.y > 800 && count_jumps >= 2:
		count_jumps = 0
	velocity.x = move_speed * move_direction
	move_and_slide(velocity)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
