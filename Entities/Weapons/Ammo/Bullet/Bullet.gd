extends Ammo
class_name Bullet

func _process(delta: float) -> void:
    global_position += specs.speed * Vector2.from_angle(global_rotation) * delta

func _on_area_2d_body_entered(_body: Node2D) -> void:
    queue_free()
