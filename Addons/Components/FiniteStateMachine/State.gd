extends Node
class_name State

signal change_state(target_state: StringName)

func enter() -> void:
    pass
    
func exit() -> void:
    pass

func input_update(_event: InputEvent) -> void:
    pass

func update(_delta: float) -> void:
    pass

func physics_update(_delta: float) -> void:
    pass
