@tool
extends VBoxContainer
class_name Slot

@export var object: PackedScene

var active: bool

func _ready() -> void:
    if object: $PanelContainer/TextureRect.texture = object.instantiate().slot_image

func _process(_delta: float) -> void:
    $HSeparator.visible = active
