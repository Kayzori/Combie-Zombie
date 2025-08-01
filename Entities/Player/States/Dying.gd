extends State

func enter() -> void:
    owner.sprite.play("dying")
    owner.direction = Vector2.ZERO
    owner.velocity = Vector2.ZERO

func _on_animations_animation_finished() -> void:
    owner.is_dead = true
