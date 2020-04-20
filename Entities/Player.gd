extends KinematicBody2D

var motion = Vector2()
var gravity = 10
var jump_speed = 200

const floor_up = Vector2(0,-1)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	motion.y += gravity
	
	if Input.is_action_pressed("left"):
		motion.x = -100
	elif Input.is_action_pressed("right"):
		motion.x = 100
	else:
		motion.x = 0
		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -jump_speed
	
	move_and_slide(motion, floor_up)
	pass
