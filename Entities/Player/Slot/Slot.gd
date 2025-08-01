extends VBoxContainer
class_name Slot

@export var object: PackedScene

var active: bool

func _process(_delta: float) -> void:
    $HSeparator.visible = active
