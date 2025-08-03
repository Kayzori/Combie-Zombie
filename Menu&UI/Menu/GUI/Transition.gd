extends Control

@onready var anim: AnimationPlayer = $AnimationPlayer

var exit_scene: String
var reload_scene: bool

func _ready() -> void:
    anim.play("Enter")

func exit(to: String) -> void:
    exit_scene = to
    anim.play("Exit")

func enter() -> void:
    anim.play("Enter")

func reload() -> void:
    reload_scene = true
    anim.play("Exit")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if anim_name == "Exit":
        get_tree().change_scene_to_file(exit_scene) if !reload_scene else get_tree().reload_current_scene()
