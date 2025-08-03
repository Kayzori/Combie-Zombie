extends Control

@export var entity_instance: PackedScene
@export var entity_stats_variable: String
@export var entity_holder: Node
@export var spawn_points: Array[Node2D]
@export var waves: Array[WaveStats]

@onready var wave_warning: Label = $WarningPanel/WaveWarning
@onready var warning_panel: PanelContainer = $WarningPanel
@onready var rest_time: Timer = $RestTime
@onready var spawn_delay: Timer = $SpawnDelay

var current_wave: WaveStats = null
var current_wave_idx: int = 0

var entity_spawned: int = 0
var wave_started: bool = false
var rest_started: bool = false
var delay_started: bool = false

func _process(_delta: float) -> void:
    update_warning()
    if waves.is_empty() or spawn_points.is_empty() or !entity_instance or GameManager.player.is_dead:
        return
    if !wave_started and !rest_started:
        current_wave = waves[current_wave_idx]
        if current_wave:
            rest_time.wait_time = current_wave.rest_time
            rest_time.start()
            rest_started = true
    elif wave_started:
        if !delay_started and entity_spawned < current_wave.amount:
            var rnd: Node2D = spawn_points.pick_random()
            var entity: Node2D = entity_instance.instantiate()
            entity.global_position = rnd.global_position
            if entity_stats_variable in entity:
                if current_wave.entity_stats:
                    entity.set(entity_stats_variable, current_wave.entity_stats)
            else:
                push_warning("Entity stats variable not found on")
            entity_holder.add_child(entity)
            spawn_delay.wait_time = current_wave.spawn_delay
            entity_spawned += 1
            delay_started = true
            spawn_delay.start()
        elif entity_spawned == current_wave.amount and entity_holder.get_child_count() == 0:
            entity_spawned = 0
            current_wave_idx = clamp(current_wave_idx + 1, 0, waves.size() - 1)
            wave_started = false

func update_warning() -> void:
    warning_panel.visible = rest_time.time_left > 0
    wave_warning.text = "Next Wave Start In: " +\
    (str("%.1f" % rest_time.time_left) if rest_time.time_left <= 3.0 else str("%d" % rest_time.time_left))
    pass

func _on_rest_time_timeout() -> void:
    rest_started = false
    wave_started = true

func _on_spawn_delay_timeout() -> void:
    delay_started = false
