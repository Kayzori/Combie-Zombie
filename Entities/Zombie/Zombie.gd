extends CharacterBody2D
class_name Zombie

@export var stats: ZombieStats
@export var drop_scene: PackedScene

@onready var sprite: AnimatedSprite2D = $Animations
@onready var hit_box: HitBoxComponent = $HitBoxComponent
@onready var health: HealthComponent = $HealthComponent

## FLAGS ##
var is_fighting: bool = false

func _ready() -> void:
    if !stats:
        push_error("Zombie Stats Not Assigned!")
    health.max_value = stats.health

func _physics_process(_delta: float) -> void:
    if GameManager.player:
        if global_position.x - GameManager.player.global_position.x > 0: sprite.flip_h = true
        elif global_position.x - GameManager.player.global_position.x < 0: sprite.flip_h = false
    move_and_slide()

func _on_health_component_died() -> void:
    if drop_scene and randf() <= stats.drop_chance:
        var drop: Collectable = drop_scene.instantiate()
        drop.global_position = global_position
        EntityPool.call_deferred("add_child", drop)
    GameManager.score += 1
    queue_free()

func _on_health_component_damaged(_amount: int) -> void:
    SFXManager.play("zombie:impact", false, true)
