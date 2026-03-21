extends CharacterBody3D

var speed: float = 5.0
var gravity: float = -9.8
var input_direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Move based on joystick input
	var direction = Vector3(input_direction.x, 0, input_direction.y)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()

	# Rotate player to face movement direction
	if direction.length() > 0.1:
		var target_angle = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, 0.15)

func set_direction(dir: Vector2):
	input_direction = dir
