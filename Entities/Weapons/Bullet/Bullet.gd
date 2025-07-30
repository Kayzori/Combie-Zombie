extends Node2D
class_name Bullet

@export var speed: float = 500.0

func _process(delta: float) -> void:
    global_position += speed * Vector2.from_angle(global_rotation) * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
    pass # Replace with function body.
