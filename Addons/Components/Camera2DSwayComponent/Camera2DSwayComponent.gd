extends Node
class_name Camera2DSwayComponent

## TODO: Camera Sway

@export var properties: Camera2DSwayProperties
var timer: float = 0.0
var sway_tween: Tween

func _physics_process(delta: float) -> void:
    if "is_shaking" in get_parent() and get_parent().is_shaking:
        return
    timer += delta * properties.speed
    var sway_offset := Vector2(
        sin(timer) * properties.amplitude.x,
        cos(timer * 1.3) * properties.amplitude.y
    )
    get_parent().offset += sway_offset

func sway_once(amount: Vector2, duration: float = 0.5) -> void:
    if sway_tween and sway_tween.is_running():
        sway_tween.kill()
    sway_tween = get_tree().create_tween()
    sway_tween.tween_property(get_parent(), "offset", amount, duration/2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
    sway_tween.tween_property(get_parent(), "offset", Vector2.ZERO, duration/2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func nudge(direction: Vector2, strength: float = 10.0, duration: float = 0.3) -> void:
    sway_once(direction.normalized() * strength, duration)
