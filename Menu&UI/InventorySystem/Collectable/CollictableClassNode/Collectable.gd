extends Area2D
class_name Collectable

@export var item: ItemTag
@export var earn: int
@export var target_group: String

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group(target_group):
        item.stock += earn
        queue_free()
