extends Resource
class_name Camera2DSwayProperties

@export var amplitude: Vector2 = Vector2(5, 3)
@export var speed: float = 1.0

func to_dict() -> Dictionary:
    return {
        "amplitude": amplitude,
        "speed": speed,
    }

func from_dict(data: Dictionary) -> void:
    amplitude = data.get("amplitude", amplitude)
    speed = data.get("speed", speed)
