extends CanvasLayer

@onready var normal: Sprite2D = $Normal
@onready var click: Sprite2D = $Click


func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta: float) -> void:
    click.visible = Input.is_action_pressed("Shot")
    normal.visible = !Input.is_action_pressed("Shot")
    normal.global_position = normal.get_global_mouse_position()
    click.global_position = normal.global_position
