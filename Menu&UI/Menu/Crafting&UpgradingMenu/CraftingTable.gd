extends Control

func _process(_delta: float) -> void:
    visible = GameManager.player.is_crafting
    if visible == false:
        $Main.visible = true
        $Craft.visible = false

func _on_carft_menu_pressed() -> void:
    $Main.visible = false
    $Craft.visible = true

func _on_craft_menu_return_pressed() -> void:
    $Main.visible = true
    $Craft.visible = false

func _on_main_menu_return_pressed() -> void:
    GameManager.player.is_crafting = false
