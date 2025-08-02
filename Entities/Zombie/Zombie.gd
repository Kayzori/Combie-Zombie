extends CharacterBody2D


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var drop_scene: PackedScene
@export var speed: float = 100.0

## FLAGS ##
var is_fighting: bool = false

func _physics_process(_delta: float) -> void:
    if global_position.x - GameManager.player.global_position.x > 0: sprite.flip_h = true
    elif global_position.x - GameManager.player.global_position.x < 0: sprite.flip_h = false
    move_and_slide()

func _on_health_component_died() -> void:
    if drop_scene:
        var drop: Collectable = drop_scene.instantiate()
        drop.global_position = global_position
        EntityPool.call_deferred("add_child", drop)
    queue_free()
