extends KinematicBody2D

var motion : Vector2= Vector2()
var gravity : float = 10
var acceleration : float = 100
var drag : float = 100
var braking : float = 150
var max_speed : float = 100
var jump_speed : float = 200
var halt_speed : float = 2

const floor_up = Vector2(0,-1)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	if Input.is_action_pressed("left"):
		if motion.x >= -max_speed:
			motion.x -= acceleration * delta
			$AnimationPlayer.play("Run")
			$Sprite.flip_h = true
		if motion.x >= 0:
			motion.x -= braking * delta
			#$Sprite.flip_h = false
			
	elif Input.is_action_pressed("right"):
		if motion.x <= max_speed:
			motion.x += acceleration * delta
			$AnimationPlayer.play("Run")
			$Sprite.flip_h = false
		if motion.x <= 0:
			motion.x += braking * delta
			#$Sprite.flip_h = true
			
	else:
		if abs(motion.x) < halt_speed :
			motion.x = 0
			$AnimationPlayer.play("Idle")
		elif motion.x > halt_speed:
			motion.x -= drag * delta
		elif motion.x < halt_speed:
			motion.x += drag * delta
	
	print_debug(motion)
	
	
	
	if is_on_floor():
		motion.y = 0
		if Input.is_action_just_pressed("jump"):
			motion.y = -jump_speed
	else:
		
		if motion.y > 0:
			$AnimationPlayer.play("Jump_falling")
		else:
			$AnimationPlayer.play("Jump_rising")
	
	motion.y += gravity
	
	move_and_slide(motion, floor_up)
	pass
