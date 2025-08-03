extends Control

@onready var pause_screen: ColorRect = $PauseScreen
@onready var pause: TextureButton = $pause
@onready var resume: TextureButton = $resume


func _on_pause_pressed() -> void:
    pause_screen.visible = true
    resume.visible = true
    pause.visible = false
    get_tree().paused = true
    SFXManager.play("gui:click")

func _on_resume_pressed() -> void:
    pause_screen.visible = false
    resume.visible = false
    pause.visible = true
    get_tree().paused = false
    SFXManager.play("gui:click")
