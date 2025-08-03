extends Area2D
class_name HitBoxComponent

@export var target_group: String
@export var damage: float = 10
@export var hit_delay: float

var time: float = 0.0
var entred_area: Node2D = null

func _ready() -> void:
    connect("area_entered", _on_area_entered)
    connect("area_exited", _on_area_exited)

func _process(delta: float) -> void:
    if !entred_area or hit_delay <= 0.0:
        time = 0.0
        return
    time += delta
    if time >= hit_delay:
        time = 0
        entred_area.receive_hit(damage)

func _on_area_entered(area: Area2D) -> void:
    if area is HurtBoxComponent and area.is_in_group(target_group):
        entred_area = area
        area.receive_hit(damage)

func _on_area_exited(area: Area2D) -> void:
    if area is HurtBoxComponent and entred_area:
        for group in entred_area.get_groups():
            if area.is_in_group(group):
                entred_area = null
