@tool
extends EditorPlugin

func _enter_tree() -> void:
    add_custom_type("FiniteStateMachine", "Node", preload("res://Addons/Components/FiniteStateMachine/FiniteStateMachine.gd"), preload("res://Addons/Components/FiniteStateMachine/plugin/theme/FiniteStateMachine.png"))

func _exit_tree() -> void:
    remove_custom_type("FiniteStateMachine")
