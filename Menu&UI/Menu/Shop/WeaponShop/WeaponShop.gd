@tool
extends PanelContainer
class_name WeaponBuy

@export var tag: WeaponShopTag

func _ready() -> void:
    if !tag: return
    $HBoxContainer/TextureRect.texture = tag.spending_item_tag.icon
    $HBoxContainer/Label.text = "x " + str(tag.spending)
    $HBoxContainer/TextureRect2.texture = tag.instance.instantiate().slot_image

func _process(_delta: float) -> void:
    if !tag or Engine.is_editor_hint(): return
    visible = tag.spending_item_tag and\
    !GameManager.player.slots.slot_objects.has(tag.instance)

func _on_texture_button_pressed() -> void:
    SFXManager.play("gui:click")
    if !tag or tag.spending_item_tag.stock < tag.spending: return
    GameManager.player.slots.add(tag.instance)
    tag.spending_item_tag.stock -= tag.spending
    visible = false
