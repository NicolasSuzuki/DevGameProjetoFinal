extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 1080
var gravity = 1200
var jump_force = -720
var count_jumps = 0
var is_grounded
onready var raycasts = $raycasts
onready var raycastsAttack = $raycastsAttack
var health = 3
var hurted = false
var knockback_dir = 1
var knockback_int = 500

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	_get_input()
	is_grounded = _check_is_ground()
	velocity = move_and_slide(velocity)
	_set_animation()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.5)
	if move_direction != 0:
		$texture.scale.x = ( - move_direction * 2.4 )
		$raycastsAttack/raycast.scale.x = - move_direction
		knockback_dir = move_direction

func _input(event: InputEvent) -> void:
	if is_grounded:
		count_jumps = 0
	if Input.is_action_just_pressed("jump") &&  count_jumps < 2:
		velocity.y = jump_force * 0.8
		count_jumps += 1

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false
	
func _set_animation():
	var anim = "idle"
	if hurted:
		anim = "damage"
	if Input.is_action_pressed("punch"):
		anim = "punch"
	if Input.is_action_pressed("kick"):
		anim = "kickAtk"
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func knockback():
	velocity.x = -knockback_dir * knockback_int
	velocity = move_and_slide(velocity)

func _on_hurtbox_body_entered(body: Node) -> void:
	health -= 1
	hurted = true

	knockback()
	get_node("hurtbox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("hurtbox/collision").set_deferred("disabled", false)
	hurted = false
	if health < 1:
		queue_free()
		get_tree().reload_current_scene()
