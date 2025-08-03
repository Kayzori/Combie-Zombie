extends Node2D

func _ready() -> void:
    for child in EntityPool.get_children():
        child.queue_free()
