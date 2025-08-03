@tool
extends HBoxContainer
class_name SlotManager

@onready var slot_instance: PackedScene = preload("res://Menu&UI/InventorySystem/Slot/Slot.tscn")
@export var slot_objects: Array[PackedScene]
@export var hand: Hand
@export var selected: int = 0
@export var fade_timer: float
@export var duration: float

var selected_slot: Slot

var active_tween: Tween
var active_timer: float

func _ready() -> void:
    for object in slot_objects:
        if object:
            var slot: Slot = slot_instance.instantiate()
            slot.object = object
            add_child(slot)
    if Engine.is_editor_hint():
        return
    selected = clamp(selected, 0, get_child_count())
    if get_child_count() != 0:
        selected_slot = get_child(selected)
        selected_slot.active = true
        hand.hold(selected_slot.object.instantiate())

func _process(delta: float) -> void:
    if Engine.is_editor_hint():
        return
    if owner.is_dead: set_process(false)
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

func add(instance_object: PackedScene) -> void:
    slot_objects.append(instance_object)
    var slot: Slot = slot_instance.instantiate()
    slot.object = instance_object
    add_child(slot)
