extends Resource
class_name Camera2DShakeProperties

@export var strenght: float = 20.0
@export var stabilization: float = 10.0
@export var time_motion: bool = true

@export_group("Time Motion Settings")
@export var time_scale: float = 0.5
@export var duration: float = 0.5
@export_enum("Slow Motion - Shake", "Shake - Slow Motion") var mode: int = 0

func _init(
    strenght_: float = 20.0,
    stabilization_: float = 5.0,
    time_motion_: bool = true,
    time_scale_: float = 0.5,
    duration_: float = 0.5,
    mode_: int = 0
) -> void:
    strenght = strenght_
    stabilization = stabilization_
    time_motion = time_motion_
    time_scale = time_scale_
    duration = duration_
    mode = mode_

func to_dict() -> Dictionary:
    return {
        "strenght": strenght,
        "stabilization": stabilization,
        "time_motion": time_motion,
        "time_scale": time_scale,
        "duration": duration,
        "mode": mode,
    }

func from_dict(data: Dictionary) -> void:
    strenght = data.get("strenght", strenght)
    stabilization = data.get("stabilization", stabilization)
    time_motion = data.get("time_motion", time_motion)
    time_scale = data.get("time_scale", time_scale)
    duration = data.get("duration", duration)
    mode = data.get("mode", mode)
