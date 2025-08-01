extends SlotObject
class_name Weapon

@export var specs: WeaponSpecs
@onready var hole: Node2D = $Hole
@onready var anim: AnimationPlayer = $AnimationPlayer

## FLAGS ##
var disable: bool = false
var unhelded: bool = true
var can_shot: bool = true
var is_reloading: bool = false

func _enter_tree() -> void:
    unhelded = false

func _process(_delta: float) -> void:
    if disable or GameManager.player.is_crafting:
        return
    if Input.is_action_just_pressed("Reload") and !is_reloading and specs.magazine < specs.capacity:
        var item: Item = get_tree().get_first_node_in_group("Player").stock.get_item(specs.stock_item)
        if item:
            item.stock = await reload(item.stock)
    if Input.is_action_pressed("Shoot") and can_shot and !is_reloading:
        if specs.magazine <= 0:
            var item: Item = get_tree().get_first_node_in_group("Player").stock.get_item(specs.stock_item)
            if item:
                item.stock = await reload(item.stock)
        else:
            fire()

func fire() -> void:
    anim.stop()
    anim.play("shot")
    if specs.shot_sfx != "":
        SFXManager.play(specs.shot_sfx, false, true)
    var ammo: Ammo = specs.ammo.instantiate()
    ammo.specs = specs.ammo_specs
    ammo.global_position = hole.global_position
    ammo.global_rotation = global_rotation + randf_range(-specs.accurency, specs.accurency) / 100
    EntityPool.add_child(ammo)

    specs.magazine -= 1
    can_shot = false
    await get_tree().create_timer(specs.fire_rate).timeout
    can_shot = true

func reload(stock: int) -> int:
    if stock == 0:
        return 0
    is_reloading = true
    if specs.reload_sfx != "":
        SFXManager.play(specs.reload_sfx, false, true)
    await get_tree().create_timer(specs.reload_time).timeout
    if unhelded: return stock
    var to_load: int = min(stock, specs.capacity - specs.magazine)

    specs.magazine += to_load
    is_reloading = false
    can_shot = true
    return stock - to_load

func _exit_tree() -> void:
    unhelded = true
