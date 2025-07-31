extends Node
class_name Camera2DShakeComponent

var rng := RandomNumberGenerator.new()
var shake_strength: float = 0.0
var enable_motion: bool = false
@export var properties: Camera2DShakeProperties
@onready var current: Camera2DShakeProperties = properties

func reset() -> void:
    current = properties.duplicate()
    Engine.time_scale = 1.0
    shake_strength = 0.0
    enable_motion = false

func shake(custom: Camera2DShakeProperties = null) -> void:
    current = (custom if custom else properties).duplicate()
    shake_strength = current.strenght
    enable_motion = true

func _physics_process(delta: float) -> void:
    if "is_shaking" in get_parent():
        get_parent().is_shaking = shake_strength > 0.1
    if not current.time_motion:
        _do_shake(delta)
    else:
        match current.mode:
            0: await _motion_then_shake(delta)
            1: await _shake_then_motion(delta)

func _random_offset() -> Vector2:
    return Vector2(
        rng.randf_range(-shake_strength, shake_strength),
        rng.randf_range(-shake_strength, shake_strength)
    )

func _do_shake(delta: float) -> void:
    if shake_strength > 0.1:
        shake_strength = lerpf(shake_strength, 0.0, current.stabilization * delta)
        get_parent().offset = _random_offset()
    else:
        reset()
        get_parent().offset = Vector2.ZERO

func _motion_then_shake(delta: float) -> void:
    if enable_motion:
        await get_tree().create_tween().tween_property(
            Engine, "time_scale", current.time_scale, (current.duration/2) * current.time_scale
        ).finished
        await get_tree().create_tween().tween_property(
            Engine, "time_scale", 1.0, (current.duration/2) * current.time_scale
        ).finished
        enable_motion = false
    _do_shake(delta)

func _shake_then_motion(delta: float) -> void:
    if enable_motion:
        Engine.time_scale = current.time_scale
        _do_shake(delta)
        await get_tree().create_timer(current.duration * current.time_scale).timeout
        Engine.time_scale = 1.0
        enable_motion = false
    if shake_strength > 0.0:
        _do_shake(delta)
