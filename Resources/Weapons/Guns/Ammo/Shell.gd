extends Ammo
class_name Shell

@export var damage_scale_distance: float

func _ready() -> void:
    var anim: Animation = $AnimationPlayer.get_animation("Damage")
    anim.track_set_key_value(2, 1, Vector2(specs.distance, 0))
    $AnimationPlayer.play("Damage")

func _process(_delta: float) -> void:
    $HitBoxComponent.damage = specs.get_damage() * damage_scale_distance

func _on_hit_box_component_body_entered(body: Node2D) -> void:
    if body is not Zombie: queue_free()
