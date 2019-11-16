extends KinematicBody2D

var motion = Vector2(0,-1)
const MAX_SPEED = 200
const ACCELERACION = 50
const GRAVITY = 20
const JUMP_HEIGHT = -550
const UP = Vector2(0,-1)
func _physics_process(delta):
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x += ACCELERACION
		motion.x = min(motion.x+ACCELERACION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("run0")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERACION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("run0")
	else:
		$Sprite.play("idle")
		friction = true
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true :
			motion.x = lerp(motion.x ,0,0.2)
	else:
		if friction == true :
			motion.x = lerp(motion.x ,0,0.05)
		if motion.y < 0 :
			$Sprite.play("jump")
		if motion.y > 0 :
			$Sprite.play("fall")
	motion.y += 15
	motion = move_and_slide(motion, UP)