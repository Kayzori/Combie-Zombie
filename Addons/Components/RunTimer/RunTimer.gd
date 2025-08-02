extends TextureProgressBar

@export var run_duration: float = 5.0          # Max stamina time in seconds
@export var regeneration_duration: float = 3.0 # Time to fully regen
@export var run_speed: float = 100.0           # Speed when running
@export var low_speed: float = 40.0            # Speed when stamina is empty
@export var base_speed: float = 70.0           # Normal movement speed

var current_speed: float
var is_regenerating: bool = false
var is_exhausted: bool = false

func _ready() -> void:
    max_value = run_duration
    value = run_duration

func _process(delta: float) -> void:
    if owner.is_running and value > 0 and not is_regenerating:
        if value > 0:
            value = max(0, value - delta)
            owner.speed = run_speed
            if value <= 0: is_regenerating = true
            is_exhausted = false
    else:
        owner.speed = low_speed
        is_exhausted = true
        if value < run_duration:
            value = min(run_duration, value + (run_duration / regeneration_duration) * delta)
            if value >= run_duration: is_regenerating = false
            
            if value > run_duration * 0.2:
                is_exhausted = false
    
        if not is_exhausted:
            owner.speed = base_speed
