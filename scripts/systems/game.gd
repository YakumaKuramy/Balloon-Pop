extends Control

class_name GameScene

@onready var spawn_timer: Timer = $spawn_timer

@onready var ballon: PackedScene = preload("res://scenes/resource/balloon.tscn")

var spawn_time_min: float = 1.2
var spawn_time_max: float = 2.0

func _ready() -> void:
	randomize()


func _on_spawn_timer_timeout() -> void:
	var new_balloon = ballon.instantiate()
	var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height") + 200

	var x = randi_range(50, screen_width - 50)
	var y = screen_height + 200
	
	new_balloon.position = Vector2(x, y)
	new_balloon.scale = Vector2(0.1, 0.1)
	add_child(new_balloon)
	
	spawn_time_min = max(0.5, spawn_time_min - 0.01)
	spawn_time_max = max(1.0, spawn_time_max - 0.01)
	
	spawn_timer.wait_time = randf_range(spawn_time_min, spawn_time_max)
	spawn_timer.start()
