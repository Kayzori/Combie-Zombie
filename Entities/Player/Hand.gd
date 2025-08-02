extends Node2D
class_name Hand

## FLAGS ##
var is_empty: bool = true
var object_held: Node2D = null

func _process(_delta: float) -> void:
    if owner.is_dead:
        queue_free()

func hold(object: Node2D) -> Node2D:
    var was_held: Node2D = drop()
    add_child(object)
    object_held = object
    is_empty = false
    return was_held

func drop() -> Node2D:
    var temp: Node2D = object_held
    if get_child_count() != 0: remove_child(object_held)
    object_held = null
    is_empty = true
    return temp
    
