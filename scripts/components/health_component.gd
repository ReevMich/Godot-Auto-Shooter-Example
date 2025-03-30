extends Node
class_name HealthComponent

signal health_changed(current_health: float, max_health: float, health_percentage: float)
signal death


@export var max_health: float = 5.0:
	set(value):
		max_health = value
		if current_health > max_health:
			current_health = max_health

var current_health: float = 5.0:
	set(value):
		current_health = clamp(value, 0, max_health)
		# Emit health changed signal
		health_changed.emit(current_health, max_health, current_health / max_health)
		
		# Check for death
		if !has_health_remaining() and !has_died:
			has_died = true
			death.emit()

var has_died: bool = false

func has_health_remaining() -> bool:
	return !is_equal_approx(current_health, 0.0)

func get_current_health_percentage() -> float:
	return current_health / max_health if max_health > 0 else 0.0

func is_damaged() -> bool:
	return current_health < max_health

func _ready():	
	call_deferred("initialize_health")

func initialize_health():
	current_health = max_health

func damage(amount: float):
	current_health -= amount
	
