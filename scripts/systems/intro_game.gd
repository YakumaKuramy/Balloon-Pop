extends Control

var menu_path: String = "res://scenes/systems/menu.tscn"

func _ready() -> void:
	await get_tree().create_timer(5).timeout
	TransitionScreen.transition_screen(menu_path)
