extends State

@onready var sprite: AnimatedSprite2D = owner.get_node("Animations")

func enter() -> void:
    owner.velocity = Vector2.ZERO
    sprite.play("idle")

func update(_delta: float) -> void:
    if Input.get_axis("Left", "Right") or Input.get_axis("Up", "Down"):
        change_state.emit("Walk")
