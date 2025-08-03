extends TextureProgressBar
class_name stamina_bar

@export var character: CharacterBody2D

@export var run_duration: float = 10.0
@export var regeneration_duration: float = 4.0
@export var run_speed: float = 100.0
@export var low_speed: float = 50.0
@export var base_speed: float = 70.0

var current_speed: float
var is_regenerating: bool = false
var is_exhausted: bool = false

func _ready() -> void:
    max_value = run_duration
    value = run_duration

func _process(delta: float) -> void:
    if not "is_running" in character:
        push_warning("'is_running' flag variable not found on: %s" % character.get_path())
        return
    if not "speed" in character:
        push_warning("'speed' variable not found on: %s" % character.get_path())
        return
    if character.is_running and value > 0 and not is_regenerating:
        if value > 0:
            value = max(0, value - delta)
            character.speed = run_speed
            if value <= 0: is_regenerating = true
            is_exhausted = false
    else:
        character.speed = low_speed
        is_exhausted = true
        if value < run_duration:
            value = min(run_duration, value + (run_duration / regeneration_duration) * delta)
            if value >= run_duration: is_regenerating = false
            
            if value > run_duration * 0.2:
                is_exhausted = false
    
        if not is_exhausted:
            owner.speed = base_speed
