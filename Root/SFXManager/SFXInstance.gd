extends AudioStreamPlayer

func _ready() -> void:
    play()

func _process(_delta: float) -> void:
    if !playing: queue_free()
