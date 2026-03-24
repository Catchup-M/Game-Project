extends Control

@onready var player_bg := $PlayerBG
@onready var player_fill := $PlayerFill
@onready var enemy_bg := $EnemyBG
@onready var enemy_fill := $EnemyFill

var bar_height := 20.0
var bar_margin := 10.0
var timer_width := 60.0
var photo_space := 70.0

func _ready():
	pass

func set_player_health(value: float, max_value: float):
	var ratio = value / max_value
	player_fill.size.x = player_bg.size.x * ratio

func set_enemy_health(value: float, max_value: float):
	var ratio = value / max_value
	enemy_fill.size.x = enemy_bg.size.x * ratio
