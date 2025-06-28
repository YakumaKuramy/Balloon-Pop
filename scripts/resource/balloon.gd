extends Area2D

class_name Balloon
@export var speed: float = 100.0

@onready var texture: Sprite2D = $texture
@onready var collision: CollisionShape2D = $collision
@onready var game: Control = get_tree().get_root().get_node_or_null("/root/game")
@onready var hud: CanvasLayer = get_tree().get_root().get_node_or_null("/root/game/HUD")



var value: int = 1
var scale_tween: Tween

func _ready() -> void:
	randomize()
	
	var red = randf_range(0.3, 1.0)
	var green = randf_range(0.3, 1.0)
	var blue = randf_range(0.3, 1.0)
	texture.modulate = Color(red, green, blue)
	
	animate_pop_effect()


func _process(delta: float) -> void:
	position.y -= speed * delta
	
	if position.y < -200:
		if scale_tween:
			scale_tween.kill()
		queue_free()


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if (event is InputEventScreenTouch and event.pressed):
		hud.add_time(5)
		
		if scale_tween:
			scale_tween.kill()
	
		collision.set_deferred("disabled", true)
		queue_free()


func animate_pop_effect():
	scale_tween = get_tree().create_tween()
	scale_tween.set_loops()  # loop infinito
	scale_tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	scale_tween.tween_property(self, "scale", Vector2(0.8, 0.8), 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
