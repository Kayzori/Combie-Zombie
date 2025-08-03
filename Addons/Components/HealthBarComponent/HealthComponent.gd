extends TextureProgressBar
class_name HealthComponent

signal died
signal damaged(amount: int)
signal healed(amount: int)

@export var visible_time: float

var time: float = 0.0

func _ready() -> void:
    value = max_value
    if visible_time > 0.0: visible = false

func _process(delta: float) -> void:
    if visible and visible_time > 0:
        time += delta
        if time >= visible_time:
            time = 0
            visible = false

func apply_damage(amount: float) -> void:
    visible = true
    value = max(value - amount, 0)
    emit_signal("damaged", amount)
    if value <= 0:
        emit_signal("died")

func apply_heal(amount: float) -> void:
    value = min(value + amount, max_value)
    emit_signal("healed", amount)
