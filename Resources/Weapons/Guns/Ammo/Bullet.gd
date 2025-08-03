extends Ammo
class_name Bullet

@onready var hit_box: HitBoxComponent = $HitBoxComponent

func _ready() -> void:
    hit_box.damage = specs.get_damage()
    $HitBoxComponent/CollisionShape2D.shape.b.x = (specs.speed * Vector2.from_angle(global_rotation) * 1/60).length()

func _physics_process(delta: float) -> void:
    global_position += specs.speed * Vector2.from_angle(global_rotation) * delta

func _on_area_2d_body_entered(_body: Node2D) -> void:
    queue_free()

func _on_hit_box_component_area_entered(area: Area2D) -> void:
    if area is HurtBoxComponent: queue_free()
