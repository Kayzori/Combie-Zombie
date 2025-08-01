extends State

func enter() -> void:
    owner.sprite.play("walk")

func physics_update(_delta: float) -> void:
    owner.direction = Vector2( \
    int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")), \
    int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up")) \
    )
    owner.direction = owner.direction.normalized()
    if !owner.direction:
        change_state.emit("idle")
    SFXManager.play("player:walk", false)
    owner.velocity = lerp(owner.velocity, owner.direction * owner.speed, 0.1)
