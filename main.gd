extends Node3D

@onready var player = $Player
@onready var joystick = $CanvasLayer/Joystick

func _ready():
	joystick.joystick_moved.connect(_on_joystick_moved)

func _on_joystick_moved(direction: Vector2):
	player.set_direction(direction)
