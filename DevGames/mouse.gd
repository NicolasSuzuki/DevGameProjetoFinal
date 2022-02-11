
extends KinematicBody2D

export var speed = 64
export var health = 2
var velocity = Vector2.ZERO
var gravity = 1200
var move_direction = -1
var hitted = false

func _physics_process(delta: float) -> void:
	velocity.x = speed * move_direction
	velocity.y +=gravity * delta

	if move_direction == 1:
		$texture.flip_h = false
	else: 
		$texture.flip_h = true
	_set_animation()
	
	velocity = move_and_slide(velocity)

func _set_animation():
	var anim = "walk"
	
	if $ray_wall.is_colliding():
		anim = "idle"
		velocity.x = 0
	elif velocity.x != 0:
		anim = "walk"
		
	if hitted:
		print("Dano")
		anim = "damage"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)

		

func _on_anim_animation_finished(anim_name):

	if anim_name == "idle":
		$texture.flip_h != $texture.flip_h
		$ray_wall.scale.x *= -1
		move_direction *= -1
		velocity.x = speed * move_direction
		$anim.play("walk")

func _on_hitbox_body_entered(body: Node) -> void:
	hitted = true
	health -= 1
	#impulso do hit
	body.velocity.y -= 300
	yield(get_tree().create_timer(0.2), "timeout")
	hitted = false
	if health < 1:
		queue_free()
		get_node("hitbox/collision").set_deferred("disabled", true)

