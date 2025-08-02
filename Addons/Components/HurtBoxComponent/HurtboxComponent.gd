extends Area2D
class_name HurtBoxComponent

@export var health_component_path: NodePath
var health_component: HealthComponent

func _ready() -> void:
    health_component = get_node(health_component_path)

func receive_hit(amount: int) -> void:
    if health_component and health_component.value > 0:
        health_component.apply_damage(amount)
