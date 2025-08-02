extends Node2D

@export var instance: PackedScene
@export var amount: int
@export var spawn_delay: float
@export var duration_between_waves: float

@onready var spawned: int
var time: float = 0.0

func _process(delta: float) -> void:
    time += delta
    if time >= spawn_delay and spawned < amount:
        time = 0
        spawned += 1
        add_child(instance.instantiate())
    if time >= duration_between_waves:
        time = 0
        spawned = 0
