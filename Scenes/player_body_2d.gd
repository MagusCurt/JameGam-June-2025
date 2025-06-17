extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const SPOUT_STRENGTH = -70.0
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("Spout") :
		velocity.y = SPOUT_STRENGTH
		gpu_particles_2d.set_emitting(true)
	if Input.is_action_just_released("Spout"):
			gpu_particles_2d.set_emitting(false)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
