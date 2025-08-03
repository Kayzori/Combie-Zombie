extends State

func enter() -> void:
    owner.is_running = true
    owner.sprite.play("walk")

func physics_update(_delta: float) -> void:
    owner.direction = Vector2( \
    int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")), \
    int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up")) \
    )
    owner.direction = owner.direction.normalized()
    if !owner.direction:
        change_state.emit("idle")
    owner.velocity = lerp(owner.velocity, owner.direction * owner.speed, 0.1)

func exit() -> void:
    owner.is_running = false

func _on_animations_frame_changed() -> void:
    if owner.sprite.animation == "walk":
        if owner.sprite.frame == 1 or owner.sprite.frame == 3:
            SFXManager.play("player:walk", true)
