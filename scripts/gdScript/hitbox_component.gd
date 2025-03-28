extends Area2D
class_name HitBoxComponent

signal hit_by_bullet(damage_amount: float)

@export var health_component: HealthComponent

func can_accept_bullet_collision() -> bool:
	return health_component.has_health_remaining() if health_component else true

func take_damage(damage_amount: float):
	# Get the damage amount from the bullet component
	
	# Apply damage to the health component
	if health_component:
		health_component.damage(damage_amount)
	
	# Emit the hit by bullet event
	hit_by_bullet.emit(damage_amount)
