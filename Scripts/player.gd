class_name Player extends CharacterBody2D

@export var gravity: float = 1000

@export var jump_force: float = 500

@export var speed: float = 200

var is_charging: bool = false

var state = ''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Handle gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	#Handle input actions
	if Input.is_action_pressed("charge"):
		is_charging = true
		$Particles.emitting = true
		state = 'charge'
	else:
		is_charging = false
		$Particles.emitting = false
		state = 'RESET'

	if not is_on_floor() and is_charging:
		# If charging in the air, apply a downward force
		velocity.y -= gravity * delta * 0.9  # Reduce gravity effect while charging in air
		#flip character
		rotation_degrees = 180
		$Particles.gravity.y = 980
	else:
		# Reset rotation when not charging
		rotation_degrees = 0
		$Particles.gravity.y = -980  # Normal gravity when not charging

	if is_charging:
		speed = 400
	else:
		speed = 200  # Reset speed to normal when not charging

	#Hand input movements
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$Sprite2D.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$Sprite2D.flip_h = true
	else:
		velocity.x = 0

	if velocity.x != 0:
		state = 'run'
	elif !is_charging:
		state = 'RESET'

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	if $AnimationPlayer.current_animation != state:
		$AnimationPlayer.play(state)
	
	move_and_slide()