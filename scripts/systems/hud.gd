extends CanvasLayer

var min_time: float = 0.0
var max_time: float = 60.0
var time_left: float = max_time
var displayed_time: float = 10.0
var time_since_last_pop: float = 0.0

var menu_path: String = "res://scenes/systems/menu.tscn"

@onready var progress_bar: TextureProgressBar = $geral/progress_bar
@onready var lbl_score: Label = $geral/lbl_score
@onready var layer_game_over: VBoxContainer = $geral/game_over



func _process(delta: float) -> void:
	time_left -= delta
	time_left = clamp(time_left, 0, max_time)
	
	time_since_last_pop += delta
	
	animate_property(progress_bar, "value", time_left, 0.2)
	
	if time_left <= 0:
		game_over()
	elif time_since_last_pop >= max_time:
		game_over()


func game_over() -> void:
	layer_game_over.visible = true


func _on_restart_button_pressed() -> void:
	TransitionScreen.restart_game()


func _on_exit_button_pressed() -> void:
	TransitionScreen.transition_screen(menu_path)


func animate_property(object: Object, property: NodePath, to_value: Variant, duration: float) -> void:
	var _tween: Tween = get_tree().create_tween()
	_tween.tween_property(object, property, to_value, duration)
