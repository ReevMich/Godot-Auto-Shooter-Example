extends Area2D
class_name HurtBoxComponent
signal hit_by_bullet(damage_amount: float)

@export var health_component: NodePath
@export var stats_component: NodePath

var _health_component: HealthComponent
var _stats_component: StatsComponent

func _ready() -> void:
	_health_component = get_node(health_component)
	_stats_component = get_node(stats_component)
	# Get the stats component from the parent (enemy)

func _apply_defense(damage: float) -> float:
	return max(0, damage - _stats_component.stats.defense)

func handle_bullet_collision(bullet: BulletComponent) -> void:
	var damage_amount = bullet.damage_amount
	var modified_damage = _apply_defense(damage_amount)
	
	# Emit the original damage amount for effects/animations
	hit_by_bullet.emit(damage_amount)
	
	# Apply the modified damage to health
	if _health_component:
		_health_component.damage(modified_damage) 
