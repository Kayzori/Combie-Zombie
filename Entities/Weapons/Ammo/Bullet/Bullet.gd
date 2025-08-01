extends Ammo
class_name Bullet

func _ready() -> void:
    $Area2D/CollisionShape2D.shape.b.x += (specs.speed * Vector2.from_angle(global_rotation) * 1/60).length()


func _physics_process(delta: float) -> void:
    global_position += specs.speed * Vector2.from_angle(global_rotation) * delta

func _on_area_2d_body_entered(_body: Node2D) -> void:
    set_process(false)
    queue_free()
