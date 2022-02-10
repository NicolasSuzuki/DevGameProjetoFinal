extends KinematicBody2D

export var speed = 64
export var health = 1
var velocity = Vector2.ZERO
var gravity = 1200
var move_direction = -1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	velocity = move_and_slide(velocity)
	
	if move_direction == 1:
		$texture.flip_h = false
	else: 
		$texture.flip_h = true
	if $ray_wall.is_colliding():
		$anim.play("idle")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_anim_animation_finished(anim_name):
	if anim_name == "idle":
		$texture.flip_h != $texture.flip_h
		$ray_wall.scale.x *= -1
		move_direction *= -1
		$anim.play("walk")
