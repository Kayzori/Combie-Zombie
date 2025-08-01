@tool
extends PanelContainer

@export var tag: CraftingTag

var stock: Stock
var spend_item: Item
var earn_item: Item

func _ready() -> void:
    if Engine.is_editor_hint():
        return
    if tag:
        if tag.spending_icon: $HBoxContainer/SpendItem.texture = tag.spending_icon
        $HBoxContainer/Spending.text = "x " + str(tag.spending)
        if tag.earning_icon: $HBoxContainer/EarnItem.texture = tag.earning_icon
        $HBoxContainer/Earning.text = "x " + str(tag.earning)
    stock = GameManager.player.stock
    spend_item = stock.get_item(tag.spend_item_name)
    earn_item = stock.get_item(tag.earn_item_name)

func _process(_delta: float) -> void:
    if Engine.is_editor_hint():
        if tag:
            if tag.spending_icon: $HBoxContainer/SpendItem.texture = tag.spending_icon
            $HBoxContainer/Spending.text = "x " + str(tag.spending)
            if tag.earning_icon: $HBoxContainer/EarnItem.texture = tag.earning_icon
            $HBoxContainer/Earning.text = "x " + str(tag.earning)
        return
    visible = spend_item and spend_item.stock >= tag.spending

func _on_texture_button_pressed() -> void:
    if Engine.is_editor_hint():
        return
    spend_item.stock -= tag.spending
    if earn_item: earn_item.stock += tag.earning
    visible = spend_item.stock < tag.spending
