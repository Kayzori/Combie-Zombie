extends Control

@onready var score: Label = %Score
@onready var best: Label = %Best

signal return_menu()
signal reload_scene()

func _process(_delta: float) -> void:
    if GameManager.player and GameManager.player.is_dead and !visible:
        get_node("%PauseMenu").visible = false
        await get_tree().create_timer(1.0).timeout
        visible = true
        var new_score: int = GameManager.score
        var old_score: int = GameManager.load_score()
        score.text = str(new_score)
        best.text = str(max(new_score, old_score))
        if new_score > old_score:
            GameManager.save_score()

func _on_new_run_pressed() -> void:
    GameManager.score = 0
    SFXManager.play("gui:click")
    get_node("%Transition").reload()

func _on_manu_pressed() -> void:
    GameManager.score = 0
    SFXManager.play("gui:click")
    get_node("%Transition").exit("res://Menu&UI/Menu/GUI/StartMenu/StartMenu.tscn")
