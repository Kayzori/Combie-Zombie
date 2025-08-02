extends SlotObject

@export var specs: MeleeSpecs
@onready var anim: AnimationPlayer = $AnimationPlayer

var switch_pos: bool = false
var can_hit: bool = true

func _process(_delta: float) -> void:
    if Input.is_action_pressed("Shoot") and can_hit:
        if switch_pos:
            anim.play("first")
        else:
            anim.play("second")
        switch_pos = !switch_pos
        can_hit = false

func set_damage() -> void:
    $HitBoxComponent.damage = specs.get_damage()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
    can_hit = true
