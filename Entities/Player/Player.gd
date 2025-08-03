extends CharacterBody2D
class_name Player

@export var heal_item: ItemTag
@export var heal_value: float
var speed: float

@onready var slots: SlotManager = %Slots
@onready var open_shot_tag: Label = %OpenShotTag
@onready var heal_tag: Label = %HealTag
@onready var sprite: AnimatedSprite2D = $Animations
@onready var hand: Hand = %Hand
@onready var body: Node2D = $Body
@onready var FSM: FiniteStateMachine = $FiniteStateMachine
@onready var health: HealthComponent = $Camera2D/Screen/HealthComponent

## FLAGS ##
var is_shoping: bool = false
var is_dead: bool = false
var is_running: bool = false
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
    pass

func _process(_delta: float) -> void:
    open_shot_tag.visible = not is_shoping
    heal_tag.visible = heal_item.stock > 0 and not is_shoping
    if Input.is_action_just_pressed("Heal") and health.value < health.max_value and heal_item.stock > 0 and not is_shoping:
        health.apply_heal(heal_value)
        heal_item.stock -= 1
    if Input.is_action_just_pressed("Shop"):
        is_shoping = !is_shoping

func _physics_process(_delta: float) -> void:
    if direction.x != 0.0:
        sprite.flip_h = direction.x < 0.0
    move_and_slide()
    rotate_body()

func rotate_body() -> void:
    var mouse_pos: Vector2 = get_global_mouse_position()
    body.look_at(mouse_pos)

    # Check if mouse is left or right of the player
    if mouse_pos.x < global_position.x:
        body.scale.y = -1   # flip vertically so it doesn't look backwards
    else:
        body.scale.y = 1

func _on_health_component_died() -> void:
    FSM.change_state("dying")

func _on_health_component_damaged(_amount: int) -> void:
    SFXManager.play("player:hurt")
