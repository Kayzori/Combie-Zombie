extends Node2D
class_name Weapon

@export var specs: WeaponSpecs
@onready var hole: Node2D = $Hole
@onready var anim: AnimationPlayer = $AnimationPlayer

## FLAGS ##
var magazine: int = 0
var can_shot: bool = true
var is_reloading: bool = false

func _process(_delta: float) -> void:
    if Input.is_action_pressed("Shoot") and can_shot and !is_reloading:
        if magazine <= 0:
            reload(10)
            return
        fire()

func fire() -> void:
    anim.play("shot")
    var ammo: Ammo = specs.ammo.instantiate()
    ammo.specs = specs.ammo_specs
    ammo.global_position = hole.global_position
    ammo.global_rotation = global_rotation + randf_range(-specs.accurency, specs.accurency) / 100
    EntityPool.add_child(ammo)

    magazine -= 1
    print("ammo left: ", magazine)
    can_shot = false
    await get_tree().create_timer(specs.fire_rate).timeout
    can_shot = true

func reload(stock: int) -> int:
    if stock == 0:
        return 0
    is_reloading = true
    print("weapon is reloading")
    await get_tree().create_timer(specs.reload_time).timeout
    var to_load: int = min(stock, specs.capacity - magazine)
    print("weapon is reloaded")
    print("ammo left: ", magazine)

    magazine += to_load
    is_reloading = false
    can_shot = true
    return stock - to_load
