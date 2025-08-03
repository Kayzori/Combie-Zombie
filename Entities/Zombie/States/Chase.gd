extends State

@export var steering_force: float = 100

@onready var path_finder: Pathfinder = $"../../PathFinderComponent"
@onready var sprite: AnimatedSprite2D = $"../../Animations"

func enter() -> void:
    sprite.play("chase")

func physics_update(delta: float) -> void:
    if not path_finder:
        return
    var desired_velocity: Vector2 = path_finder.move_dir * owner.stats.speed
    var steering: Vector2 = (desired_velocity - owner.velocity) * steering_force
    owner.velocity += steering * delta

    if owner.velocity.length() > owner.stats.speed:
        owner.velocity = owner.velocity.normalized() * owner.stats.speed


func _on_hit_box_component_body_entered(body: Node2D) -> void:
    if body is Player:
        change_state.emit("attacking")

func _on_animations_frame_changed() -> void:
    if owner and owner.sprite.animation == "chase":
        if owner.sprite.frame == 1 or owner.sprite.frame == 3:
            SFXManager.play("zombie:walk", false, true)
