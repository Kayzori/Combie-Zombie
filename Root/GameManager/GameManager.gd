extends Node

@onready var player: Player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
    if player:
        player._ready()

func _process(_delta: float) -> void:
    if !player:
        player = get_tree().get_first_node_in_group("Player")
