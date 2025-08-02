extends State

func enter() -> void:
    owner.is_dead = true
    owner.sprite.play("dying")
    owner.direction = Vector2.ZERO
    owner.velocity = Vector2.ZERO
