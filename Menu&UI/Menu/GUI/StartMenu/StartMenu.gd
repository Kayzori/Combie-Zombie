extends Node2D

@onready var main: PanelContainer = $Border/Main
@onready var options: PanelContainer = $Border/Options
@onready var credit: PanelContainer = $Border/Credit
@onready var transition: Control = $Transition

func _ready() -> void:
    for child in EntityPool.get_children():
        child.queue_free()
    main.visible = true
    options.visible = false
    credit.visible = false

func _on_play_pressed() -> void:
    SFXManager.play("gui:click")
    transition.exit("res://World/World.tscn")

func _on_options_pressed() -> void:
    SFXManager.play("gui:click")
    main.visible = false
    options.visible = true
    credit.visible = false

func _on_main_return_pressed() -> void:
    SFXManager.play("gui:click")
    main.visible = true
    options.visible = false
    credit.visible = false

func _on_credit_pressed() -> void:
    SFXManager.play("gui:click")
    main.visible = false
    options.visible = false
    credit.visible = true
