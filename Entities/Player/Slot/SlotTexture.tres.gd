@tool
extends TextureRect

func _ready() -> void:
    if owner.object and not texture: texture = owner.object.instantiate().slot_image
