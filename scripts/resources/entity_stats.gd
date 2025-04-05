class_name EntityStats extends Resource

# Signal static typed
signal stats_changed(new_stats: EntityStats)

# Core Stats
@export var max_health: float = 100.0
@export var attack_damage: float = 10.0
@export var defense: float = 0.0 #NOT USED
@export var move_speed: float = 100.0

# Combat Stats
@export var attack_speed: float = 1.0
@export var critical_chance: float = 0.05 #NOT USED
@export var critical_damage: float = 1.5 #NOT USED
@export var dodge_chance: float = 0.0 #NOT USED


# Status Effects
var active_effects: Array[StatusEffect] = []

func update_stats(new_stats: EntityStats) -> void:
	max_health = new_stats.max_health
	attack_damage = new_stats.attack_damage
	defense = new_stats.defense
	move_speed = new_stats.move_speed
	attack_speed = new_stats.attack_speed
	critical_chance = new_stats.critical_chance
	
	stats_changed.emit(self)

func get_stats() -> EntityStats:
	return self

func get_max_health() -> float:
	return max_health
	
