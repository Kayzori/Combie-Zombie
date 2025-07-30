extends CharacterBody2D

@onready var hand: Node2D = %Hand
@onready var body: Node2D = $Body

func rotate_body() -> void:
    body.look_at(get_global_mouse_position())
    pass

func _process(_delta: float) -> void:
    rotate_body()
    pass
