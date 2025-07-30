extends Node2D
class_name Weapon

@export var weapon_specs: WeaponSpecs

@onready var bullet_exit: Node2D = $BulletExit
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
    var bullet: Bullet = weapon_specs._Bullet.instantiate()
    bullet.global_position = bullet_exit.global_position
    bullet.global_rotation = global_rotation + randf_range(-weapon_specs.Accurency, weapon_specs.Accurency)/100
    EntityPool.add_child(bullet)

    magazine -= 1
    can_shot = false
    await get_tree().create_timer(weapon_specs.Precision).timeout
    can_shot = true

func reload(stock: int) -> int:
    if stock == 0:
        return 0
    is_reloading = true
    await get_tree().create_timer(weapon_specs.ReloadTime).timeout
    var space = weapon_specs.Capacity - magazine
    var to_load = min(stock, space)

    magazine += to_load
    is_reloading = false
    can_shot = true
    return stock - to_load
