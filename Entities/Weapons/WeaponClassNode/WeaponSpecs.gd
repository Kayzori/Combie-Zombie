extends Resource
class_name WeaponSpecs

@export var name: StringName
@export var stock_item: String
@export var shot_sfx: String
@export var reload_sfx: String
@export var ammo: PackedScene
@export var ammo_specs: AmmoSpecs
@export var capacity: int
@export var fire_rate: float
@export var accurency: float
@export var reload_time: float

var magazine: int = 0
