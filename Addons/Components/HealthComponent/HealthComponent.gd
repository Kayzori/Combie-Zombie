extends TextureProgressBar
class_name HealthComponent

signal died
signal damaged(amount: int)
signal healed(amount: int)

@export var max_health: int = 100
@export var visible_time: float

var time: float = 0.0

func _ready() -> void:
    max_value = max_health
    value = max_health
    if visible_time > 0.0: visible = false

func _process(delta: float) -> void:
    if visible and visible_time > 0:
        time += delta
        if time >= visible_time:
            time = 0
            visible = false

func apply_damage(amount: int) -> void:
    visible = true
    value = max(value - amount, 0)
    emit_signal("damaged", amount)
    if value <= 0:
        emit_signal("died")
        

func apply_heal(amount: int) -> void:
    value = min(value + amount, max_health)
    emit_signal("healed", amount)
