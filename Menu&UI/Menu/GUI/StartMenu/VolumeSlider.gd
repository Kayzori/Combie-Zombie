extends HSlider

@export var bus: String

var bus_index: int

func _ready() -> void:
    bus_index = AudioServer.get_bus_index(bus)
    value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
    value_changed.connect(_on_value_changed)
    drag_ended.connect(drag_end)

func _on_value_changed(_value: float) -> void:
    AudioServer.set_bus_volume_linear(
        bus_index,
        value
    )
func drag_end() -> void:
    SFXManager.play("gui:click")
