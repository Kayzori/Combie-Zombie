extends Control

@onready var crafting_recipes: GridContainer = %CraftingRecipes

func _process(_delta: float) -> void:
    visible = GameManager.player.is_crafting and !GameManager.player.is_dead
    if visible == false:
        $Main.visible = true
        $Ammo.visible = false
        $Weapon.visible = false

func _on_ammo_menu_pressed() -> void:
    $Main.visible = false
    $Ammo.visible = true
    $Weapon.visible = false

func _on_weapon_menu_pressed() -> void:
    $Main.visible = false
    $Ammo.visible = false
    $Weapon.visible = true

func _on_menu_return_pressed() -> void:
    $Main.visible = true
    $Ammo.visible = false
    $Weapon.visible = false

func _on_main_menu_return_pressed() -> void:
    GameManager.player.is_crafting = false
