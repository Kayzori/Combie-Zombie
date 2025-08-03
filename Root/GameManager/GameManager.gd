extends Node

@onready var player: Player = get_tree().get_first_node_in_group("Player")

var score: int = 0

func _ready() -> void:
    if player:
        player._ready()
    load_score()

func _process(_delta: float) -> void:
    if !player:
        player = get_tree().get_first_node_in_group("Player")

func save_score() -> void:
    var file: FileAccess = FileAccess.open("user://save.dat", FileAccess.WRITE)
    if file:
        file.store_var(score)
        file.close()
    else:
        print("Failed to save file")

func load_score() -> int:
    if FileAccess.file_exists("user://save.dat"):
        var file: FileAccess = FileAccess.open("user://save.dat", FileAccess.READ)
        if file:
            var best: int = file.get_var()
            file.close()
            return best
        return 0
    else:
        return 0
