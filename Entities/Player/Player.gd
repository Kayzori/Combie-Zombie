extends CharacterBody2D

@export var speed: float = 200.0

@onready var hand: Node2D = %Hand
@onready var body: Node2D = $Body

## TODO player states + zombie class node

func rotate_body() -> void:
    body.look_at(get_global_mouse_position())

func _physics_process(_delta: float) -> void:
    rotate_body()
