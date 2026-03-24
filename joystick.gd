extends Control

@onready var base := $JoystickBase
@onready var knob := $JoystickKnob

var base_radius: float
var knob_start_pos: Vector2
var is_pressed := false

func _ready():
	base_radius = base.size.x / 4.0
	knob_start_pos = base.size / 2.0 - knob.size / 2.0
	knob.position = knob_start_pos

func _input(event):
	if event is InputEventMouseButton:
		is_pressed = event.pressed
		if not is_pressed:
			knob.position = knob_start_pos

	if event is InputEventScreenTouch:
		is_pressed = event.pressed
		if not is_pressed:
			knob.position = knob_start_pos

	if event is InputEventMouseMotion and is_pressed:
		_move_knob(event.position)

	if event is InputEventScreenDrag and is_pressed:
		_move_knob(event.position)

func _move_knob(global_pos: Vector2):
	var local_pos = base.get_global_transform().affine_inverse() * global_pos
	var center = base.size / 2.0
	var direction = local_pos - center

	if direction.length() > base_radius:
		direction = direction.normalized() * base_radius

	knob.position = center + direction - knob.size / 2.0
