@tool
extends PanelContainer
class_name CraftingRecipe

@export var crafting_tag: CraftingTag

func _ready() -> void:
    if !crafting_tag:
        return
    if crafting_tag.spend_item_tag:
        $HBoxContainer/SpendItem.texture = crafting_tag.spend_item_tag.icon
        $HBoxContainer/Spending.text = "x " + str(crafting_tag.spending)
    if crafting_tag.earn_item_tag:
        $HBoxContainer/EarnItem.texture = crafting_tag.earn_item_tag.icon
        $HBoxContainer/Earning.text = "x " + str(crafting_tag.earning)

func _process(_delta: float) -> void:
    if !crafting_tag or Engine.is_editor_hint(): return
    visible = crafting_tag.spend_item_tag and\
    crafting_tag.spend_item_tag.stock >= crafting_tag.spending and\
    GameManager.player.slots.slot_objects.has(crafting_tag.weapon_needed)

func _on_texture_button_pressed() -> void:
    if Engine.is_editor_hint() or !crafting_tag: return
    crafting_tag.spend_item_tag.stock -= crafting_tag.spending
    if crafting_tag.earn_item_tag:
        crafting_tag.earn_item_tag.stock += crafting_tag.earning
    visible = crafting_tag.earn_item_tag.stock < crafting_tag.spending
