extends Control

@onready var main: PanelContainer = $Main
@onready var ammo: PanelContainer = $Ammo
@onready var weapon: PanelContainer = $Weapon

func _process(_delta: float) -> void:
    visible = GameManager.player.is_shoping and !GameManager.player.is_dead
    if visible == false:
        main.visible = true
        ammo.visible = false
        weapon.visible = false

func _on_ammo_menu_pressed() -> void:
    main.visible = false
    ammo.visible = true
    weapon.visible = false
    SFXManager.play("gui:click")

func _on_weapon_menu_pressed() -> void:
    main.visible = false
    ammo.visible = false
    weapon.visible = true
    SFXManager.play("gui:click")

func _on_menu_return_pressed() -> void:
    main.visible = true
    ammo.visible = false
    weapon.visible = false
    SFXManager.play("gui:click")

func _on_main_menu_return_pressed() -> void:
    GameManager.player.is_shoping = false
    SFXManager.play("gui:click")
