extends Control

var knob: TextureRect
var base: TextureRect
var base_center: Vector2
var max_distance: float = 70.0
var is_dragging: bool = false

signal joystick_moved(direction: Vector2)

func _ready():
	base = $Base
	knob = $Base/Knob
	# Get the center of the base
	base_center = base.size / 2
	# Place knob at center
	knob.position = base_center - knob.size / 2

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			is_dragging = true
		else:
			is_dragging = false
			reset_knob()

	if event is InputEventScreenTouch:
		if event.pressed:
			is_dragging = true
		else:
			is_dragging = false
			reset_knob()

	if event is InputEventMouseMotion and is_dragging:
		move_knob(get_local_mouse_position())

	if event is InputEventScreenDrag and is_dragging:
		move_knob(event.position - global_position)

func move_knob(touch_pos: Vector2):
	var offset = touch_pos - base_center
	# Clamp knob inside the circle
	if offset.length() > max_distance:
		offset = offset.normalized() * max_distance
	knob.position = base_center + offset - knob.size / 2
	# Send direction between -1 and 1
	emit_signal("joystick_moved", offset / max_distance)

func reset_knob():
	knob.position = base_center - knob.size / 2
	emit_signal("joystick_moved", Vector2.ZERO)
