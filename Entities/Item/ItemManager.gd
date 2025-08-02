extends VBoxContainer
class_name ItemManager

func get_item(item_tag: ItemTag) -> Item:
    for item: Item in get_children():
        if item.tag == item_tag:
            return item
    return null
