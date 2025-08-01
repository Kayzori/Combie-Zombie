extends Control
class_name Item

@export var item_name: String
@export var stock: int = 0

func _process(_delta: float) -> void:
    visible = stock
    $Label.text = "x " + str(stock)
