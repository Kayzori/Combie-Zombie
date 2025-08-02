extends State

func enter() -> void:
    owner.sprite.play("attack")
    owner.velocity = Vector2(0, 0)

func _on_hit_box_component_body_exited(body: Node2D) -> void:
    if body is Player:
        change_state.emit("chasing")
