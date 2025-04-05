class_name StatusEffect 
extends Resource

enum EFFECT_TYPE { BUFF, DEBUFF, DOT, HOT }

@export var effect_name: String
@export var effect_type: EFFECT_TYPE
@export var duration: float = 0.0  # 0 means permanent until removed
@export var tick_rate: float = 0.0  # 0 means no tick
@export var value: float = 0.0
@export var is_percentage: bool = false

var time_remaining: float
var time_since_last_tick: float

func _init():
	time_remaining = duration
	time_since_last_tick = 0.0

func tick(delta: float) -> bool:
	if tick_rate <= 0:
		return true
		
	time_since_last_tick += delta
	if time_since_last_tick >= tick_rate:
		time_since_last_tick = 0.0
		return true
	return false

func update(delta: float) -> bool:
	if duration <= 0:
		return true
		
	time_remaining -= delta
	return time_remaining > 0 
