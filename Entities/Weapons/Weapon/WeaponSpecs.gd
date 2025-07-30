extends Resource
class_name WeaponSpecs

@export var _Bullet: PackedScene
@export var Capacity: int
@export var Damage: float
@export var Precision: float
@export var Accurency: float
@export var ReloadTime: float
@export_range(0.0, 1.0, 0.1) var FatalShotChance: float
@export var FatalShotDamageScale: float

var fatal_shot: bool

func get_damage() -> float:
    if randf() <= FatalShotChance:
        fatal_shot = true
        return Damage * FatalShotDamageScale
    else:
        fatal_shot = false
        return Damage
