extends VBoxContainer
class_name Stock

func get_item(item_name: String) -> Item:
    for item: Item in get_children():
        if item.item_name == item_name:
            return item
    return null
