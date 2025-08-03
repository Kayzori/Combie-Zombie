@tool
extends PanelContainer
class_name AmmoShop

@export var tag: AmmoShopTag

func _ready() -> void:
    if !tag:
        return
    if tag.spend_item_tag:
        $HBoxContainer/SpendItem.texture = tag.spend_item_tag.icon
        $HBoxContainer/Spending.text = "x " + str(tag.spending)
    if tag.earn_item_tag:
        $HBoxContainer/EarnItem.texture = tag.earn_item_tag.icon
        $HBoxContainer/Earning.text = "x " + str(tag.earning)

func _process(_delta: float) -> void:
    if !tag or Engine.is_editor_hint(): return
    visible = tag.spend_item_tag and\
    (tag.weapon_needed == null or GameManager.player.slots.slot_objects.has(tag.weapon_needed))

func _on_texture_button_pressed() -> void:
    SFXManager.play("gui:click")
    if Engine.is_editor_hint() or !tag or tag.spend_item_tag.stock < tag.spending: return
    tag.spend_item_tag.stock -= tag.spending
    if tag.earn_item_tag:
        tag.earn_item_tag.stock += tag.earning
    visible = tag.earn_item_tag.stock < tag.spending
