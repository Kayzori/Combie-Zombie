extends CharacterBody2D
class_name Player

@export var speed: float = 200.0
@export var weapons: Dictionary[String, PackedScene]
@onready var slots: SlotManager = %Slots

@onready var sprite: AnimatedSprite2D = $Animations
@onready var hand: Hand = %Hand
@onready var body: Node2D = $Body
@onready var FSM: FiniteStateMachine = $FiniteStateMachine

## FLAGS ##
var is_on_crafting_table: bool = true
var is_crafting: bool = false
var is_dying: bool = false
var is_dead: bool = false
var is_running: bool = false
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
    pass

func _process(_delta: float) -> void:
    $Camera2D/Screen/Label.text = str(Engine.get_frames_per_second()) + " FPS"
    if is_on_crafting_table and Input.is_action_just_pressed("CraftingTable"):
        is_crafting = !is_crafting
    if Input.is_action_just_pressed("kill"):
        FSM.change_state("dying")

func _physics_process(_delta: float) -> void:
    if direction.x != 0.0:
        sprite.flip_h = direction.x < 0.0
    move_and_slide()
    rotate_body()

func rotate_body() -> void:
    body.look_at(get_global_mouse_position())


func _on_health_component_died() -> void:
    FSM.change_state("dying")
