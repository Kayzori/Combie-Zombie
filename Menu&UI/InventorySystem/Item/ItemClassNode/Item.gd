@tool
extends Control
class_name Item
 
@export var tag: ItemTag
@export var visible_when_stock: bool

func _process(_delta: float) -> void:
    if tag:
        if tag.icon: $TextureRect.texture = tag.icon
        if visible_when_stock: visible = tag.stock
        else: visible = true
        $Label.text = "x " + str(tag.stock)
