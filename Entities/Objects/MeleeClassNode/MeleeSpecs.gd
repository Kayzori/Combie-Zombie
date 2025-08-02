extends Resource
class_name MeleeSpecs

@export var damage: float
@export_range(0.0, 1.0, 0.1) var fatal_shot_chance: float
@export var fatal_shot_damage_scale: float

var fatal_shot: bool

func get_damage() -> float:
    if randf() <= fatal_shot_chance:
        fatal_shot = true
        return damage * fatal_shot_damage_scale
    else:
        fatal_shot = false
        return damage
