extends Control


func _on_button_play_pressed() -> void:
	TransitionScreen.transition_screen("res://scenes/game_scene/game.tscn")
