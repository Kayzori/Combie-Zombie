extends HBoxContainer

@export var hand: Hand
@export var selected: int = 0
@export var fade_timer: float
@export var duration: float

var selected_slot: Slot

var active_tween: Tween
var active_timer: float

func _ready() -> void:
    if get_child_count() != 0:
        selected_slot = get_child(selected)
        selected_slot.active = true
        hand.hold(selected_slot.object.instantiate())

func _process(delta: float) -> void:
    var change: int = int(Input.is_action_just_released("Next Slot")) - int(Input.is_action_just_released("Previous Slot"))
    if change or selected_slot == null:
        active_timer = 0
        modulate.a = 1.0
        if active_tween and active_tween.is_running():
            active_tween.kill()
            active_tween = null
        selected_slot.active = false
        selected = clamp(selected + change, 0, get_child_count() - 1)
        selected_slot = get_child(selected)
        selected_slot.active = true
        hand.hold(selected_slot.object.instantiate())
    else:
        active_timer += delta
        if active_timer >= fade_timer:
            fade()

func fade() -> void:
    if active_tween and active_tween.is_running():
        active_tween.kill()
        active_tween = null
    active_tween = get_tree().create_tween()
    active_tween.tween_property(self, "modulate:a", 0.25, duration)
